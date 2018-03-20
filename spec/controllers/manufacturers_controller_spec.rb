require 'rails_helper'

RSpec.describe ManufacturersController, type: :controller do
  login_employee
  render_views

  before(:each) do
    @manufacturer = FactoryGirl.create(:manufacturer, organization: @employee.organization)
  end

  context '#index' do
    it 'renders the index page of manufacturers' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should load the manufacturer associated with organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:manufacturers)).to include (@manufacturer)
    end

    it 'should not include the manufacturer of other organization' do
      new_org = FactoryGirl.create(:organization)
      @manufacturer.update_attribute(:organization_id, new_org.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:manufacturers).empty?).to be true
    end
  end

  context '#new' do
    it 'should render the new page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:manufacturer)).to be_a_new(Manufacturer)
    end
  end

  context '#create' do
    context 'sucessful' do
      it 'should create new manufacturer record' do
        expect(Manufacturer.count).to eq(1)
        post :create, manufacturer_attrs
        manufacturer = assigns(:manufacturer)
        expect(Manufacturer.count).to eq(2)
        expect(manufacturer.name).to eq('manufacturer-1234')
        expect(manufacturer.number).to eq('1234')
        expect(manufacturer.start_date).to eq(Date.today)
        expect(manufacturer.end_date).to eq(Date.tomorrow)
        expect(manufacturer.end_reason).to eq('MyText')
        expect(manufacturer.contacts.size).to be(2)
        expect(manufacturer.addresses.size).to be(2)
        expect(manufacturer.phones.size).to be(2)
      end

      it 'page should redirect to manufacturer listing page' do
        expect(Manufacturer.count).to eq(1)
        post :create, manufacturer_attrs
        expect(Manufacturer.count).to eq(2)
        expect(response).to redirect_to organization_manufacturers_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not create manufacturer record and renders the new page with errors' do
        expect {
              post :create, organization_id: @employee.organization_id, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: '')
        }.to change { Manufacturer.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end

  context '#update' do
    context 'sucessful' do
      it 'should update the manufacturer record' do
        attrs = manufacturer_attrs_update.merge({id: @manufacturer.id})
        attrs[:manufacturer][:name] = 'paritosh' 
        put :update, attrs
        manufacturer = assigns(:manufacturer)
        expect(assigns(:manufacturer).name).to eq 'paritosh'
        expect(manufacturer.start_date).to eq(Date.today)
        expect(manufacturer.end_date).to eq(Date.tomorrow)
        expect(manufacturer.end_reason).to eq('MyText')
        expect(manufacturer.addresses.size).to be(1)
        expect(manufacturer.addresses.first.address).to eq('MyString')
        expect(manufacturer.addresses.first.state).to eq('MyString')
        expect(manufacturer.addresses.first.country).to eq('MyString')
        expect(manufacturer.addresses.first.zip).to eq('12345')
        expect(manufacturer.contacts.size).to be(1)
        expect(manufacturer.contacts.first.first_name).to eq('ABC')
        expect(manufacturer.contacts.first.last_name).to eq('XYZ')
        expect(manufacturer.contacts.first.middle_name).to eq('M')
        expect(manufacturer.phones.size).to be(1)
      end

      it 'page should redirects to manufacturer listing' do
        attrs = manufacturer_attrs_update.merge({id: @manufacturer.id})
        put :update, attrs
        expect(response).to redirect_to organization_manufacturers_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not update the manufacturer if name is missing and render the edit page' do
        attrs = manufacturer_attrs.merge({id: @manufacturer.id})
        attrs[:manufacturer][:name] = ''
        put :update, attrs
        expect(response).to render_template('edit')
      end
    end
  end

  context 'destroy' do
    it 'delete the manufacturer' do
      expect { delete :destroy, organization_id: @manufacturer.organization_id, id: @manufacturer}.to change(Manufacturer,:count).by(-1)
    end
  end


  def manufacturer_attrs
    phone_type = FactoryGirl.create :phone_type
    {
      organization_id: @employee.organization_id,
      manufacturer: FactoryGirl.attributes_for(:manufacturer, number: 1234, name: 'manufacturer-1234')
                         .merge({'contacts_attributes' =>  {'0' => FactoryGirl.attributes_for(:contact, is_primary: true),
                                                            '1' => FactoryGirl.attributes_for(:contact, is_primary: false)}})
                         .merge({'addresses_attributes' => {'0' => FactoryGirl.attributes_for(:address, is_primary: true),
                                                            '1' => FactoryGirl.attributes_for(:address, is_primary: false)}})
                         .merge({'phones_attributes' =>    {'0' => FactoryGirl.attributes_for(:phone, is_primary: true, phone_type_id: phone_type.id),
                                                            '1' => FactoryGirl.attributes_for(:phone, is_primary: false, phone_type_id: phone_type.id)}})
    }
  end

  def manufacturer_attrs_update
    {
      organization_id: @employee.organization_id,
      manufacturer: FactoryGirl.attributes_for(:manufacturer)
                               .merge(address_attr)
                               .merge(phone_attr)
                               .merge(contact_attr)
    }
  end

  def address_attr
    {
      'addresses_attributes' => {'0' => FactoryGirl.attributes_for(:address),
                                 '1' => FactoryGirl.attributes_for(:address, :_destroy => 1)}
    }
  end


  def phone_attr
    phone_type = FactoryGirl.create :phone_type
    {
      'phones_attributes' => {'0' => FactoryGirl.attributes_for(:phone, phone_type_id: phone_type.id),
                              '1' => FactoryGirl.attributes_for(:phone, :_destroy => 1, phone_type_id: phone_type.id)}
    }
  end

  def contact_attr
    {
      'contacts_attributes' => {'0' => FactoryGirl.attributes_for(:contact),
                                '1' => FactoryGirl.attributes_for(:contact, :_destroy => 1)}
    }
  end

end
