class DropCustomerContactInfo < ActiveRecord::Migration
  def change
    drop_table :customer_contact_infos
  end
end
