class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.references :business, index: true
      t.string :last_name
      t.string :first_name
      t.string :middle_initial
      t.string :job_title
      t.string :department
      t.string :subcontractor_name
      t.integer :employee_number
      t.string :ssn
      t.decimal :hourly_rate
      t.decimal :gross_salary
      t.decimal :taxes
      t.decimal :net_salary
      t.date :start_date
      t.date :end_date
      t.text :end_reason_notes
      t.integer :end_reason_type_code
      t.integer :end_reason_item_code
      t.text :contact_notes
      t.string :email_address1
      t.string :email_address2
      t.string :email_address3
      t.string :phone_number1
      t.string :phone_number2
      t.string :phone_number3
      t.string :phone_ext1
      t.string :phone_ext2
      t.string :phone_ext3
      t.integer :phone_type_code1
      t.integer :phone_type_code2
      t.integer :phone_type_code3
      t.integer :phone_item_code1
      t.integer :phone_item_code2
      t.integer :phone_item_code3
      t.integer :email_type_code1
      t.integer :email_type_code2
      t.integer :email_type_code3
      t.integer :email_item_code1
      t.integer :email_item_code2
      t.integer :email_item_code3
      t.integer :status_type_code
      t.integer :status_item_code
      t.integer :created_by
      t.integer :modified_by

      t.timestamps null: false
    end
    add_foreign_key :employees, :businesses
  end
end
