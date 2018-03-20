class AddEmployeeToUser < ActiveRecord::Migration
  def change
    add_reference :users, :employee, index: true
    add_foreign_key :users, :employees
  end
end
