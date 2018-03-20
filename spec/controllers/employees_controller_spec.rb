require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  login_employee
  render_views

  context '#index' do
    it 'renders the index page' do
      get :index, organization_id: @employee.organization_id
      expect(response).to render_template('index')
    end

    it 'should load the employee associated with organization' do
      get :index, organization_id: @employee.organization_id
      expect(assigns(:employees)).to include(@employee)
    end

    it 'should not include the employee of other organization' do
      new_org = FactoryGirl.create(:organization)
      @employee.update_attribute(:organization_id, new_org.id)
      get :index, organization_id: @employee.organization_id
      expect(assigns(:employees).empty?).to be false
    end
  end

  context '#new' do
    it 'should render the new page' do
      get :new, organization_id: @employee.organization_id
      expect(response).to render_template('new')
      expect(assigns(:employee)).to be_a_new(Employee)
    end
  end

  context '#create' do
    context '#sucessful' do
      it 'should create new employee record' do
        expect(Employee.count).to eq(1)
        post :create, employee_attrs
        employee = assigns(:employee)
        expect(Employee.count).to eq(2)
        expect(employee.first_name).to eq('John')
        expect(employee.last_name).to eq('parley')
        expect(employee.middle_name).to eq('M')
        expect(employee.email).to eq('test@example.com')
        expect(employee.organization_id).to eq(@employee.organization_id)
        expect(employee.employee_info.ssn).to eq('test')
        expect(employee.employee_info.start_date).to eq(Date.today)
        expect(employee.employee_info.end_date).to eq(Date.tomorrow)
        expect(employee.employee_info.hourly).to eq(12323)
        expect(employee.employee_info.gross).to eq(12323)
        expect(employee.employee_info.tax).to eq(12)
        expect(employee.employee_info.net).to eq(723823)
        expect(employee.addresses.size).to be(2)
        expect(employee.phones.size).to be(2)
        expect(employee.employee_info).to be_valid
      end

      it 'page should redirect to employee listing page' do
        expect(Employee.count).to eq(1)
        post :create, employee_attrs
        employee = assigns(:employee)
        expect(Employee.count).to eq(2)
        expect(response).to redirect_to organization_employees_path(assigns(:organization))
      end
    end

    context '#unsucessful' do
      it 'should not create employee record and renders the new page with errors' do
        expect {
          attrs = employee_attrs.merge({id: @employee.id})
          attrs[:employee][:need_login]= 'true'
          attrs[:employee][:email]= ''
          post :create, attrs
        }.to change { Employee.count}.by (0)
        expect(response).to render_template('new')
      end
    end
  end

  context '#update' do
    context '#successful' do
      it 'should update the page record' do
        attrs = employee_attrs_update.merge({id: @employee.id})
        attrs[:employee][:first_name]= 'Rahul'
        attrs[:employee][:last_name] = 'Pandit'
        attrs[:employee][:middle_name] = 'M'
        attrs[:employee]["employee_info_attributes"][:ssn] = 'new_test'
        attrs[:employee]["employee_info_attributes"][:start_date] = Date.today.to_s
        attrs[:employee]["employee_info_attributes"][:end_date] = Date.tomorrow.to_s
        attrs[:employee]["employee_info_attributes"][:hourly] = 123
        attrs[:employee]["employee_info_attributes"][:gross] = 1234
        attrs[:employee]["employee_info_attributes"][:tax] = 10
        attrs[:employee]["employee_info_attributes"][:net] = 4312
        put :update, attrs
        employee = assigns(:employee)
        expect(assigns(:employee).first_name).to eq 'Rahul'
        expect(employee.last_name).to eq 'Pandit'
        expect(employee.middle_name).to eq 'M'
        expect(employee.employee_info.ssn).to eq('new_test')
        expect(employee.employee_info.start_date).to eq(Date.today)
        expect(employee.employee_info.end_date).to eq(Date.tomorrow)
        expect(employee.employee_info.hourly).to eq(123)
        expect(employee.employee_info.hourly_rate).to eq(12300)
        expect(employee.employee_info.gross).to eq(1234)
        expect(employee.employee_info.gross_salary).to eq(123400)
        expect(employee.employee_info.tax).to eq(10)
        expect(employee.employee_info.taxes).to eq(1000)
        expect(employee.employee_info.net).to eq(4312)
        expect(employee.employee_info.net_salary).to eq(431200)
        expect(employee.addresses.size).to be(1)
        expect(employee.phones.size).to be(1)
      end

      it 'page should redirect to employees listing' do
        attrs = employee_attrs.merge({id: @employee.id})
        attrs[:employee][:first_name]= 'paritosh'
        put :update, attrs
        expect(response).to redirect_to organization_employees_path(assigns(:organization))
      end
    end

    context '#unsucessful' do
      it 'should not update the employee if the employee no and first_name is missing' do
        attrs = employee_attrs.merge({id: @employee.id})
        attrs[:employee][:first_name]= ''
        put :update, attrs
        expect(response).to render_template('edit')
      end
    end
  end

  context '#destroy' do
    it 'delete the employee' do
      expect { delete :destroy, organization_id: @employee.organization_id, id: @employee}.to change(Employee, :count).by(-1)
    end
  end

  def employee_attrs
     phone_type = FactoryGirl.create :phone_type
    {
      organization_id: @employee.organization_id,
      employee: FactoryGirl.attributes_for(:employee, email: 'test@example.com', first_name: 'John', last_name: 'parley')
      .merge({'employee_info_attributes' => FactoryGirl.attributes_for(:employee_info, ssn: 'test', hourly: '12,323.00', gross: '12,323.00', tax: '12.00', net: '723,823.00', end_reason: 'Some reason', need_login: "1" )})
      .merge({ 'addresses_attributes' => { '0' => FactoryGirl.attributes_for(:address, _destroy: false),
                                           '142712340' => FactoryGirl.attributes_for(:address, _destroy: false, is_primary: false)}})
      .merge({ 'phones_attributes' => { '0' => FactoryGirl.attributes_for(:phone, _destroy: false, phone_type_id: phone_type.id),
                                        '14923042' => FactoryGirl.attributes_for(:phone, _destroy: false, is_primary: false, phone_type_id: phone_type.id)}})
    }
  end

  def employee_attrs_update
    {
      organization_id: @employee.organization_id,
      employee: FactoryGirl.attributes_for(:employee)
      .merge({'employee_info_attributes' => FactoryGirl.attributes_for(:employee_info, ssn: 'test', hourly: '12,323.00', gross: '12,323.00', tax: '12.00', net: '723,823.00', end_reason: 'Some reason', need_login: "1" )})
                           .merge(address_attr)
                           .merge(phone_attr)
    }
  end

  def address_attr
    {
      'addresses_attributes' => { '0' => FactoryGirl.attributes_for(:address) ,
                                  '1' => FactoryGirl.attributes_for(:address, is_primary: false, _destroy: true) }
    }
  end

  def phone_attr
    phone_type = FactoryGirl.create :phone_type
    {
      'phones_attributes' => { '0' => FactoryGirl.attributes_for(:phone, phone_type_id: phone_type.id),
                               '1'=> FactoryGirl.attributes_for(:phone, is_primary: false, _destroy: true, phone_type_id: phone_type.id) }
    }
  end
end
