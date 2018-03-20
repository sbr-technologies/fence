class FixBusinessContactInfoTable < ActiveRecord::Migration
  def change
    remove_column :business_contact_infos, :contact_type_id, :integer
    remove_column :business_contact_infos, :contact_data, :string
    remove_column :business_contact_infos, :status_id, :integer
    remove_column :business_contact_infos, :created_by, :integer
    remove_column :business_contact_infos, :updated_by, :integer
    remove_column :business_contact_infos, :created_at, :datetime
    remove_column :business_contact_infos, :updated_at, :datetime
    add_column :business_contact_infos, :contact_data, :string
    add_column :business_contact_infos, :phone_email_type_code, :integer
    add_column :business_contact_infos, :phone_email_item_code, :integer
    add_column :business_contact_infos, :status_type_code, :integer
    add_column :business_contact_infos, :status_item_code, :integer
    add_column :business_contact_infos, :created_by, :integer
    add_column :business_contact_infos, :modified_by, :integer
    add_column :business_contact_infos, :created_at, :datetime,            null: false
    add_column :business_contact_infos, :updated_at, :datetime,            null: false
  end
end
