class FixManufacturerAddress < ActiveRecord::Migration
  def change

    remove_column :manufacturer_addresses, :created_by, :integer
    remove_column :manufacturer_addresses, :modified_by, :integer
    remove_column :manufacturer_addresses, :created_at, :datetime
    remove_column :manufacturer_addresses, :updated_at, :datetime
    add_column :manufacturer_addresses, :status_type_code, :integer
    add_column :manufacturer_addresses, :status_item_code, :integer
    add_column :manufacturer_addresses, :created_by, :integer
    add_column :manufacturer_addresses, :modified_by, :integer
    add_column :manufacturer_addresses, :created_at, :datetime,            null: false
    add_column :manufacturer_addresses, :updated_at, :datetime,            null: false
  end
end
