class DropAddressType < ActiveRecord::Migration
  def change
    remove_column :customer_addresses, :address_type_id, :integer
    drop_table :address_types
    
  end
end
