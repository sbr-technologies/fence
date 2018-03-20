class FixBusinessAddress < ActiveRecord::Migration
  def change
    remove_column :business_addresses, :created_by, :integer
    remove_column :business_addresses, :modified_by, :integer
    remove_column :business_addresses, :created_at, :datetime
    remove_column :business_addresses, :updated_at, :datetime
    add_column :business_addresses, :status_type_code, :integer
    add_column :business_addresses, :status_item_code, :integer
    add_column :business_addresses, :created_by, :integer
    add_column :business_addresses, :modified_by, :integer
    add_column :business_addresses, :created_at, :datetime,            null: false
    add_column :business_addresses, :updated_at, :datetime,            null: false
  end
end
