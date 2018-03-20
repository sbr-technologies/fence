class DropPhoneType < ActiveRecord::Migration
  def change
    remove_column :phones, :phone_type_id, :integer
    drop_table :phone_types 
  end
end
