require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  login_employee
  render_views

  before(:each) do
    @supplier = FactoryGirl.create(:supplier, organization: @employee.organization)
  end

  context '#index' do
    it 'render index page of suppliers' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should loads supplier associated with current organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:suppliers)).to include(@supplier)
    end

    it 'should not include the other organization suppliers' do
      new_org = FactoryGirl.create(:organization)
      @supplier.update_attribute(:organization_id, new_org.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:suppliers).empty?).to be true
    end
  end

  context '#new' do
    it 'should render the new page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:supplier)).to be_a_new(Supplier)
    end
  end

  context '#create' do
    context 'sucessful' do
      it 'should create new supplier record' do
        expect(Supplier.count).to eq(1)
        post :create, supplier_attrs
        supplier = assigns(:supplier)
        expect(Supplier.count).to eq(2)
        expect(supplier.name).to eq('Test Abc')
        expect(supplier.start_date).to eq(Date.today)
        expect(supplier.end_date).to eq(Date.tomorrow)
        expect(supplier.organization_id).to eq(@employee.organization_id)
        expect(supplier.end_reason).to eq('MyText')
        expect(supplier.addresses.size).to be(2)
        expect(supplier.addresses.first.address).to eq('MyString')
        expect(supplier.addresses.first.state).to eq('MyString')
        expect(supplier.addresses.first.country).to eq('MyString')
        expect(supplier.addresses.first.city).to eq('MyString')
        expect(supplier.addresses.first.zip).to eq("12345")
        expect(supplier.phones.size).to be(2)
        expect(supplier.contacts.size).to be(2)
      end

      it 'page should redirects to suppliers listing page' do
        expect(Supplier.count).to eq(1)
        post :create, supplier_attrs
        supplier = assigns(:supplier)
        expect(Supplier.count).to eq(2)
        expect(supplier.addresses.size).to eq(2)
        expect(supplier.phones.size).to eq(2)
        expect(supplier.contacts.size).to eq(2)
        expect(response).to redirect_to organization_suppliers_path(assigns(:organization))
      end
    end

    context 'unsuccessful' do
      it 'should not create supplier record and renders the new page with errors' do
        expect {
          post :create, organization_id: @employee.organization_id, supplier: FactoryGirl.attributes_for(:supplier, name: '')
        }.to change { Supplier.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end


  context '#update' do
    context 'successful' do
      it 'should update supplier record' do
        attrs = supplier_attrs.merge({id: @supplier.id})
        attrs[:supplier][:name] = 'b.c construction'
        attrs[:supplier][:end_reason] = 'some end reason'
        attrs[:supplier]["addresses_attributes"]["0"].merge!(:address => 'set new address', :city => 'set new city', :state => 'set new state', :country => 'set new country', 'id' => @supplier.addresses.first.id)
        put :update, attrs
        supplier = assigns(:supplier)
        expect(assigns(:supplier).name).to eq 'b.c construction'
        expect(supplier.start_date).to eq(Date.today)
        expect(supplier.end_date).to eq(Date.tomorrow)
        expect(supplier.end_reason).to eq('some end reason')
        expect(supplier.addresses.size).to eq(2)
        expect(supplier.addresses.first.address).to eq('set new address')
        expect(supplier.addresses.first.state).to eq('set new state')
        expect(supplier.addresses.first.country).to eq('set new country')
        expect(supplier.addresses.first.city).to eq('set new city')
        expect(supplier.addresses.first.zip).to eq('12345')
        expect(supplier.addresses.first.is_primary).to eq(true)
        expect(supplier.contacts.first.first_name).to eq('ABC')
        expect(supplier.contacts.first.last_name).to eq('XYZ')
        expect(supplier.contacts.first.middle_name).to eq('M')
        expect(supplier.phones.first.number).to eq('123 123 1234')
      end

      it 'page should redirects to suppliers listing' do
        attrs = supplier_attrs.merge({id: @supplier.id})
        attrs[:supplier][:name] = '123sku'
        put :update, attrs
        expect(response).to redirect_to organization_suppliers_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not update the supplier if name is missing and render the edit page' do
        attrs = supplier_attrs.merge({id: @supplier.id})
        attrs[:supplier][:name] = ''
        put :update, attrs 
        expect(response).to render_template('edit')
      end
    end
  end

  context '#destroy' do
    it 'deletes the supplier' do
      expect{ delete :destroy, organization_id: @employee.organization_id, id: @supplier }.to change(Supplier,:count).by(-1)
    end
  end

  #TODO
  #it 'Employee need to login to visit supplier page' do
    #sign_out @employee
    #get :index, organization_id: @employee.organization_id
    #expect(response).to redirect_to new_user_session_path
  #end

  def supplier_attrs
    phone_type = FactoryGirl.create :phone_type
    {
      organization_id: @employee.organization_id, 
      supplier: FactoryGirl.attributes_for(:supplier, name: 'Test Abc')
                            .merge({'addresses_attributes' => {'0' => FactoryGirl.attributes_for(:address, is_primary: true),
                                                               '1' => FactoryGirl.attributes_for(:address, is_primary: false)}})
                            .merge({'phones_attributes' =>    {'0' => FactoryGirl.attributes_for(:phone, is_primary: true, phone_type_id: phone_type.id),
                                                               '1' => FactoryGirl.attributes_for(:phone, is_primary: false, phone_type_id: phone_type.id) }})
                            .merge({'contacts_attributes' =>  {'0' => FactoryGirl.attributes_for(:contact, is_primary: true),
                                                               '1' => FactoryGirl.attributes_for(:contact, is_primary: false)}})
    }
  end

  def supplier_attrs_update
    {
      organization_id: @employee.organization_id, 
      supplier: FactoryGirl.attributes_for(:supplier)
                            .merge(address_attr)
                            .merge(phone_attr)
                            .merge(contact_attr)
    }
  end

  def address_attr
    {
      :addresses_attributes => {'0' => FactoryGirl.attributes_for(:address),
                                '1' => FactoryGirl.attributes_for(:address, :_destroy => 1)}
    }
  end

  def phone_attr
    phone_type = FactoryGirl.create :phone_type
    {
      :phones_attributes => {'0' => FactoryGirl.attributes_for(:phone, phone_type_id: phone_type.id),
                             '1' => FactoryGirl.attributes_for(:phone, :_destroy => 1, phone_type_id: phone_type.id)}
    }
  end

  def contact_attr
    {
      :contacts_attributes => {'0' => FactoryGirl.attributes_for(:contact),
                               '1' => FactoryGirl.attributes_for(:contact, :_destroy => 1)}
    }
  end

end
