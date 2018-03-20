class AddStatusFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :status_type_code, :integer
    add_column :users, :status_item_code, :integer
  end
end
