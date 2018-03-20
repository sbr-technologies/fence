class CreateBusinessContactPeople < ActiveRecord::Migration
  def change
    create_table :business_contact_people do |t|
      t.references :business, index: true
      t.string :last_name
      t.string :first_name
      t.string :middle_initial
      t.string :job_title
      t.string :department
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
    add_foreign_key :business_contact_people, :businesses
  end
end
