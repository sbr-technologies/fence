class RemoveFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :type, :string
    remove_column :users, :need_login, :boolean
  end
end
