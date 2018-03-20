class DropCustomerAddress < ActiveRecord::Migration
  def change
    drop_table :customer_addresses
  end
end
