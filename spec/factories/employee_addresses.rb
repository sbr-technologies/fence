FactoryGirl.define do
  factory :employee_address do
    business nil
employee_id nil
line_1 "MyString"
line_2 "MyString"
city "MyString"
state "MyString"
zip "MyString"
zip_suffix_code "MyString"
primary_address false
directions "MyString"
address_type_code 1
address_item_code 1
created_by 1
modified_by 1
  end

end
