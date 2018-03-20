class DropEmployeeTables < ActiveRecord::Migration
  def change
    drop_table :employee_infos
    drop_table :employee_phones
    drop_table :employee_addresses
  end
end
