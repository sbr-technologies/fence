class FixEmployeeAddress < ActiveRecord::Migration
  def change
    remove_column :employee_addresses, :created_by, :integer
    remove_column :employee_addresses, :modified_by, :integer
    remove_column :employee_addresses, :created_at, :datetime
    remove_column :employee_addresses, :updated_at, :datetime
    add_column :employee_addresses, :status_type_code, :integer
    add_column :employee_addresses, :status_item_code, :integer
    add_column :employee_addresses, :created_by, :integer
    add_column :employee_addresses, :modified_by, :integer
    add_column :employee_addresses, :created_at, :datetime,            null: false
    add_column :employee_addresses, :updated_at, :datetime,            null: false
  end
end
