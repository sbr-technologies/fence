class RemoveColumnsFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :biz_name, :string
    remove_column :customers, :biz_account_nmbr, :string
  end
end
