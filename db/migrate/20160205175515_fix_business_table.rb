class FixBusinessTable < ActiveRecord::Migration
  def change
    rename_column :businesses, :license_nmbr, :license_number
    remove_column :businesses, :status_type_code, :integer
    remove_column :businesses, :status_item_code, :integer
    remove_column :businesses, :created_by, :integer
    remove_column :businesses, :modified_by, :integer
    remove_column :businesses, :created_at, :datetime
    remove_column :businesses, :updated_at, :datetime
    add_column :businesses, :website_address, :string
    add_column :businesses, :status_type_code, :integer
    add_column :businesses, :status_item_code, :integer
    add_column :businesses, :created_by, :integer
    add_column :businesses, :modified_by, :integer
    add_column :businesses, :created_at, :datetime,            null: false
    add_column :businesses, :updated_at, :datetime,            null: false
    
  end
end
