class StandardizeMiddleInitial < ActiveRecord::Migration
  def change
    rename_column :customers, :mi, :middle_initial
    rename_column :users, :middle_name, :middle_initial
    rename_column :suppliers, :middle_name, :middle_initial
    rename_column :manufacturers, :middle_name, :middle_initial
  end
end
