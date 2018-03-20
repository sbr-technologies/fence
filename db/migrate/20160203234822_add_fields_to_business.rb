class AddFieldsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :business_name, :string
    add_column :businesses, :license_nmbr, :string
    add_column :businesses, :status_type_code, :integer
    add_column :businesses, :status_item_code, :string
    add_column :businesses, :created_by, :integer
    add_column :businesses, :updated_by, :integer
  end
end
