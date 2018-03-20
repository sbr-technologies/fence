class CreateCustomerPhones < ActiveRecord::Migration
  def change
    create_table :customer_phones do |t|
      t.references :business, index: true
      t.references :customer, index: true
      t.string :phone_number
      t.string :phone_number_ext
      t.boolean :is_primary
      t.integer :phone_type_code
      t.integer :phone_item_code
      t.integer :status_type_code
      t.integer :status_item_code
      t.integer :created_by
      t.integer :modified_by

      t.timestamps null: false
    end
    add_foreign_key :customer_phones, :businesses
    add_foreign_key :customer_phones, :customers
  end
end