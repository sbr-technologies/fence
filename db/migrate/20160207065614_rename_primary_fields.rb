class RenamePrimaryFields < ActiveRecord::Migration
  def change
    rename_column :business_addresses, :primary_address, :is_primary
    rename_column :customer_addresses, :primary_address, :is_primary
    rename_column :supplier_addresses, :primary_address, :is_primary
    rename_column :manufacturer_addresses, :primary_address, :is_primary

  end
end
