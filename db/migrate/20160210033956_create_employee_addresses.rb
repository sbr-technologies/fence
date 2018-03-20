class CreateEmployeeAddresses < ActiveRecord::Migration
  def change
    create_table :employee_addresses do |t|
      t.references :business, index: true
      t.references :employee, index: true
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :zip_suffix_code
      t.boolean :primary_address
      t.string :directions
      t.integer :address_type_code
      t.integer :address_item_code
      t.integer :created_by
      t.integer :modified_by

      t.timestamps null: false
    end
    add_foreign_key :employee_addresses, :businesses
    add_foreign_key :employee_addresses, :employees
  end
end
