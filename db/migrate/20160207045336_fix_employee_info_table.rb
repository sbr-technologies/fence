class FixEmployeeInfoTable < ActiveRecord::Migration
  def change
    remove_column :employee_infos, :employee_no, :integer
    remove_column :employee_infos, :ssn, :string
    remove_column :employee_infos, :hourly_rate, :decimal
    remove_column :employee_infos, :gross_salary, :decimal
    remove_column :employee_infos, :taxes, :decimal
    remove_column :employee_infos, :net_salary, :decimal
    remove_column :employee_infos, :start_date, :date
    remove_column :employee_infos, :end_date, :date
    remove_column :employee_infos, :end_reason, :text
    remove_column :employee_infos, :created_at, :datetime
    remove_column :employee_infos, :updated_at, :datetime
    add_column :employee_infos, :employee_no, :integer
    add_column :employee_infos, :ssn, :string
    add_column :employee_infos, :hourly_rate, :decimal
    add_column :employee_infos, :gross_salary, :decimal
    add_column :employee_infos, :taxes, :decimal
    add_column :employee_infos, :net_salary, :decimal
    add_column :employee_infos, :start_date, :date
    add_column :employee_infos, :end_date, :date
    add_column :employee_infos, :end_reason_notes, :text
    add_column :employee_infos, :end_reason_type_code, :integer
    add_column :employee_infos, :end_reason_item_code, :integer
    add_column :employee_infos, :status_type_code, :integer 
    add_column :employee_infos, :status_item_code, :integer 
    add_column :employee_infos, :created_by, :integer
    add_column :employee_infos, :modified_by, :integer
    add_column :employee_infos, :created_at, :datetime,            null: false
    add_column :employee_infos, :updated_at, :datetime,            null: false

  end
end


