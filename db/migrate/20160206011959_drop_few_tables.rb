class DropFewTables < ActiveRecord::Migration
  def change
    drop_table :customer_phones
    drop_table :supplier_phones
    drop_table :manufacturer_phones
    drop_table :customer_contact_people
    drop_table :supplier_contact_people
    drop_table :manufacturer_contact_people   
  end
end
