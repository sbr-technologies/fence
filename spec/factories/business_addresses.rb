FactoryGirl.define do
  factory :business_address do
    business nil
address_type nil
line_1 "MyString"
line_2 "MyString"
city "MyString"
state "MyString"
zip "MyString"
zip_suffix_code "MyString"
primary_address false
directions "MyString"
created_by 1
updated_by 1
  end

end
