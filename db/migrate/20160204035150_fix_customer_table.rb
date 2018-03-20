class FixCustomerTable < ActiveRecord::Migration
  def change
    remove_column :customers, :start_date, :date
    remove_column :customers, :end_date, :date
    remove_column :customers, :created_by, :integer
    remove_column :customers, :updated_by, :integer
    remove_column :customers, :created_at, :datetime
    remove_column :customers, :updated_at, :datetime
    remove_column :customers, :end_reason_notes, :text
    remove_column :customers, :email, :string
    add_column :customers, :business_name, :string
    add_column :customers, :business_account_nmbr, :string
    add_column :customers, :end_reason_notes, :text
    add_column :customers, :email, :string
    add_column :customers, :start_date, :date
    add_column :customers, :end_date, :date
    add_column :customers, :end_reason_type_code, :integer
    add_column :customers, :end_reason_item_code, :integer
    add_column :customers, :status_type_code, :integer
    add_column :customers, :status_item_code, :integer
    add_column :customers, :created_by, :integer
    add_column :customers, :modified_by, :integer
    add_column :customers, :created_at, :datetime,            null: false
    add_column :customers, :updated_at, :datetime,            null: false



  end
end


