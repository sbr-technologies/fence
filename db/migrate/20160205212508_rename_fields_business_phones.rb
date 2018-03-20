class RenameFieldsBusinessPhones < ActiveRecord::Migration
  def change
    rename_column :business_phones, :phone_email_type_code, :phone_type_code
    rename_column :business_phones, :phone_email_item_code, :phone_item_code
  end
end
