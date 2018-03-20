class FixEmployee < ActiveRecord::Migration
  def change
    remove_column :employees, :created_by, :integer
    remove_column :employees, :modified_by, :integer
    remove_column :employees, :created_at, :datetime
    remove_column :employees, :updated_at, :datetime
    add_column :employees, :employee_type_code, :integer
    add_column :employees, :employee_item_code, :integer
    add_column :employees, :created_by, :integer
    add_column :employees, :modified_by, :integer
    add_column :employees, :created_at, :datetime,            null: false
    add_column :employees, :updated_at, :datetime,            null: false

  end
end
