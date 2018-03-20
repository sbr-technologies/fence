class RemoveTheseColumnsFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :end_reason_id, :integer
    remove_column :customers, :status_id, :integer
  end
end
