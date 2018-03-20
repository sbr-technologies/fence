class RenameFieldInEmployeeAddress < ActiveRecord::Migration
  def change
    rename_column :employee_addresses, :primary_address, :is_primary

  end
end
