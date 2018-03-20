class FixSupplierAddress < ActiveRecord::Migration
  def change
    remove_column :supplier_addresses, :created_by, :integer
    remove_column :supplier_addresses, :modified_by, :integer
    remove_column :supplier_addresses, :created_at, :datetime
    remove_column :supplier_addresses, :updated_at, :datetime
    add_column :supplier_addresses, :status_type_code, :integer
    add_column :supplier_addresses, :status_item_code, :integer
    add_column :supplier_addresses, :created_by, :integer
    add_column :supplier_addresses, :modified_by, :integer
    add_column :supplier_addresses, :created_at, :datetime,            null: false
    add_column :supplier_addresses, :updated_at, :datetime,            null: false

  end
end
