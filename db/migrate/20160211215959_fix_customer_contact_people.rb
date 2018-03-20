class FixCustomerContactPeople < ActiveRecord::Migration
  def change

    remove_column :customer_contact_people, :status_type_code, :integer
    remove_column :customer_contact_people, :status_item_code, :integer
    remove_column :customer_contact_people, :created_by, :integer
    remove_column :customer_contact_people, :modified_by, :integer
    remove_column :customer_contact_people, :created_at, :datetime
    remove_column :customer_contact_people, :updated_at, :datetime
    add_column :customer_contact_people, :contact_type_code, :integer
    add_column :customer_contact_people, :contact_item_code, :integer
    add_column :customer_contact_people, :status_type_code, :integer
    add_column :customer_contact_people, :status_item_code, :integer
    add_column :customer_contact_people, :created_by, :integer
    add_column :customer_contact_people, :modified_by, :integer
    add_column :customer_contact_people, :created_at, :datetime,            null: false
    add_column :customer_contact_people, :updated_at, :datetime,            null: false
  end
end
