FactoryGirl.define do
  factory :business_phone do
    business nil
phone_number "MyString"
phone_number_ext "MyString"
is_primary false
phone_email_type_code 1
phone_email_item_code 1
status_type_code 1
status_item_code 1
created_by 1
modified_by 1
  end

end
