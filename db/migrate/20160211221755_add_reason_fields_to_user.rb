class AddReasonFieldsToUser < ActiveRecord::Migration
  def change

    add_column :users, :start_date, :date
    add_column :users, :end_date, :date
    add_column :users, :end_reason_type_code, :integer
    add_column :users, :end_reason_item_code, :integer
    add_column :users, :end_reason_notes, :text
  end
end
