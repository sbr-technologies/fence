# bart_f 2-11-16 READ BELOW NOTES:
# Only data not required in production should be here.
# If it needs to be there in production, it belongs in seeds.rb.
# e.g. usage rake command to run:  rake db:drop db:create db:schema:load db:seed app:load_demo_data

namespace :app do
  desc <<-DESC
    Load testing data.
    Run using the command 'rake db:drop db:create db:schema:load db:seed app:load_demo_data'
  DESC
  task :load_demo_data => [:environment] do

	#creates test business 1
	role = Role.find_or_create_by(name: 'Enterprise Admin', level: 1)
	org = Business.find_or_create_by(business_name: 'business_name_org_1')
	emp = Employee.create!(email_address1: "test@org1.com", first_name: 'Paul', last_name: 'Enamul', middle_initial: 'D', business_id: org.id, employee_number: '1', ssn: '123')
	user = User.create!(email: emp.email_address1, password: 'test123', business_id: org.id, first_name: emp.first_name, last_name: emp.last_name, middle_initial: emp.middle_initial, role_id: role.id, employee_id: emp.id )
	user.confirm!
	Manufacturer.find_or_create_by(business_name: 'JM eagle', business_account_number: '1', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'B.C. Landscape Construction', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'Abiqua Rental', business_id: org.id)

	#creates test business 2
	org = Business.find_or_create_by(business_name: 'business_name_org_2')
	emp = Employee.create!(email_address1: "test@org2.com", first_name: 'Tim', last_name: 'John', middle_initial: 'H', business_id: org.id, employee_number: '1', ssn: '124')
	user = User.create!(email: emp.email_address1, password: 'test123', business_id: org.id, first_name: emp.first_name, last_name: emp.last_name, middle_initial: emp.middle_initial, role_id: role.id, employee_id: emp.id )
	user.confirm!
	Manufacturer.find_or_create_by(business_name: 'JM eagle', business_account_number: '1', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'Balley Seed', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'General Rental Center', business_id: org.id)

	#creates test business 3
	org = Business.find_or_create_by(business_name: 'business_name_org_3')
	emp = Employee.create!(email_address1: "test@org3.com", first_name: 'Bob', last_name: 'Crown', middle_initial: 'R', business_id: org.id, employee_number: '1', ssn: '125')
	user = User.create!(email: emp.email_address1, password: 'test123', business_id: org.id, first_name: emp.first_name, last_name: emp.last_name, middle_initial: emp.middle_initial, role_id: role.id, employee_id: emp.id )
	user.confirm!
	Manufacturer.find_or_create_by(business_name: 'JM eagle', business_account_number: '1', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'Ez-Grade', business_id: org.id)
	Supplier.find_or_create_by(business_name: 'Capital Rental Center', business_id: org.id)

  end
end

