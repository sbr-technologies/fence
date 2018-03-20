class ReviseSupplierTable < ActiveRecord::Migration
  def change
    rename_column :suppliers, :name, :lastname
    remove_column :suppliers, :start_date, :date
    remove_column :suppliers, :end_date, :date
    remove_column :suppliers, :end_reason_type_code, :integer
    remove_column :suppliers, :end_reason_item_code, :integer
    remove_column :suppliers, :end_reason_notes, :text
    remove_column :suppliers, :status_type_code, :integer
    remove_column :suppliers, :status_item_code, :integer
    remove_column :suppliers, :created_by, :integer
    remove_column :suppliers, :modified_by, :integer
    remove_column :suppliers, :created_at, :datetime
    remove_column :suppliers, :updated_at, :datetime
    add_column :suppliers, :first_name, :string
    add_column :suppliers, :middle_name, :string
    add_column :suppliers, :business_name, :string
    add_column :suppliers, :business_account_number, :string
    add_column :suppliers, :start_date, :date
    add_column :suppliers, :end_date, :date
    add_column :suppliers, :end_reason_type_code, :integer
    add_column :suppliers, :end_reason_item_code, :integer
    add_column :suppliers, :end_reason_notes, :text
    add_column :suppliers, :status_type_code, :integer
    add_column :suppliers, :status_item_code, :integer
    add_column :suppliers, :created_by, :integer
    add_column :suppliers, :modified_by, :integer
    add_column :suppliers, :created_at, :datetime,            null: false
    add_column :suppliers, :updated_at, :datetime,            null: false

  end
end
