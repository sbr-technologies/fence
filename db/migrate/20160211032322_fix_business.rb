class FixBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :license_number, :string
    remove_column :businesses, :website_address, :string
    remove_column :businesses, :status_type_code, :integer
    remove_column :businesses, :status_item_code, :integer
    remove_column :businesses, :created_by, :integer
    remove_column :businesses, :modified_by, :integer
    remove_column :businesses, :created_at, :datetime
    remove_column :businesses, :updated_at, :datetime

    add_column :businesses, :last_name, :string
    add_column :businesses, :first_name, :string
    add_column :businesses, :middle_initial, :string    
    add_column :businesses, :license_number, :string
    add_column :businesses, :website_address, :string
    add_column :businesses, :status_type_code, :integer
    add_column :businesses, :status_item_code, :integer
    add_column :businesses, :created_by, :integer
    add_column :businesses, :modified_by, :integer
    add_column :businesses, :created_at, :datetime,            null: false
    add_column :businesses, :updated_at, :datetime,            null: false
  end
end
