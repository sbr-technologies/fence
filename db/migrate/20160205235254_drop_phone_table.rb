class DropPhoneTable < ActiveRecord::Migration
  def change
    drop_table :phones
  end
end
