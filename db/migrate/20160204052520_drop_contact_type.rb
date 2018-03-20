class DropContactType < ActiveRecord::Migration
  def change
    remove_column :customer_contact_infos, :contact_type_id, :integer
    drop_table :contact_types    

  end
end
