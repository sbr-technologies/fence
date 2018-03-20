require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  login_employee
  render_views

  before(:each) do
    @customer = FactoryGirl.create(:customer, organization: @employee.organization)
  end

  context '#index' do
    it 'renders the index page of customers' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should load the customer associated with organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:customers)).to include (@customer)
    end

    it 'should not include the customer of other organization' do
      new_org = FactoryGirl.create(:organization)
      @customer.update_attribute(:organization_id, new_org.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:customers).empty?).to be true
    end
  end

  context '#new' do
    it 'should render the new page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:customer)).to be_a_new(Customer)
    end
  end

  context '#create' do
    context 'sucessful' do
      it 'should create new customer record' do
        expect(Customer.count).to eq(1)
        post :create, customer_attr
        customer = assigns(:customer)
        expect(Customer.count).to eq(2)
        expect(customer.name).to eq('abcd')
        expect(customer.margin_percent).to eq(0)
        expect(customer.last_name).to eq('cd')
        expect(customer.middle_name).to eq('A')
        expect(customer.first_name).to eq('ab')
        expect(customer.start_date).to eq(Date.today)
        expect(customer.end_date).to eq(Date.tomorrow)
        expect(customer.organization_ac).to eq('abc')
        expect(customer.end_reason).to eq('MyText')
        expect(customer.organization_id).to eq(@employee.organization_id)
        expect(customer.status).to eq('Active')
        expect(customer.addresses.size).to be(2)
        expect(customer.phones.size).to be(2)
      end

      it 'page should redirect to customer listing page' do
        expect(Customer.count).to eq(1)
        post :create, customer_attr
        expect(Customer.count).to eq(2)
        expect(response).to redirect_to organization_customers_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not create customer record and renders the new page with errors' do
        expect {
              post :create, organization_id: @employee.organization_id, customer: FactoryGirl.attributes_for(:customer, name: '', first_name: '', last_name: '')
        }.to change { Customer.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end

  context '#update' do
    context 'sucessful' do
      it 'should update the customer record' do
        attrs = customer_attrs_update.merge({id: @customer.id})
        attrs[:customer][:first_name] = 'paritosh'
        put :update, attrs
        @customer.reload
        expect(@customer.first_name).to eq 'paritosh'
        expect(@customer.addresses.size).to be(1)
        expect(@customer.phones.size).to be(1)
      end

      it 'page should redirects to customer listing' do
        attrs = customer_attr.merge({id: @customer.id})
        attrs[:customer][:first_name] = 'paritosh'
        put :update, attrs
        expect(response).to redirect_to organization_customers_path(assigns(:organization))
      end
    end

    context 'unsucessful' do
      it 'should not update the customer if name is missing and render the edit page' do
        put :update, organization_id: @employee.organization_id, id: @customer.id, customer: { first_name: '', name: ''}
        expect(response).to render_template('edit')
      end
    end
  end

  context 'destroy' do
    it 'delete the customer' do
      expect { delete :destroy, organization_id: @customer.organization_id, id: @customer}.to change(Customer,:count).by(-1)
    end
  end


  def customer_attr
    phone_type = FactoryGirl.create :phone_type
    {
      organization_id: @employee.organization_id,
      customer: FactoryGirl.attributes_for(:customer, name: 'abcd', last_name: 'cd', first_name: 'ab')
                         .merge({'addresses_attributes' => {'0' => FactoryGirl.attributes_for(:address, is_primary: true),
                                                            '1' => FactoryGirl.attributes_for(:address, is_primary: false)}})
                         .merge({'phones_attributes' =>    {'0' => FactoryGirl.attributes_for(:phone, is_primary: true, phone_type_id: phone_type.id),
                                                            '1' => FactoryGirl.attributes_for(:phone, is_primary: false, phone_type_id: phone_type.id)}})
    }
  end

  def customer_attrs_update
    {
      organization_id: @employee.organization_id,
      customer: FactoryGirl.attributes_for(:customer)
                            .merge(address_attr)
                            .merge(phone_attr)
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
end
