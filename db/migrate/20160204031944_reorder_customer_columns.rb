class ReorderCustomerColumns < ActiveRecord::Migration
  def change

    change_column :customers, :end_reason_notes, :text, after: :end_date
    change_column :customers, :email, :string, after: :mi
  end
end
