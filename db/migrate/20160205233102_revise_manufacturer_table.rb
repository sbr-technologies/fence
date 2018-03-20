class ReviseManufacturerTable < ActiveRecord::Migration
  def change
    rename_column :manufacturers, :name, :lastname
    remove_column :manufacturers, :number, :string
    remove_column :manufacturers, :start_date, :date
    remove_column :manufacturers, :end_date, :date
    remove_column :manufacturers, :end_reason_type_code, :integer
    remove_column :manufacturers, :end_reason_item_code, :integer
    remove_column :manufacturers, :end_reason_notes, :text
    remove_column :manufacturers, :status_type_code, :integer
    remove_column :manufacturers, :status_item_code, :integer
    remove_column :manufacturers, :created_by, :integer
    remove_column :manufacturers, :modified_by, :integer
    remove_column :manufacturers, :created_at, :datetime
    remove_column :manufacturers, :updated_at, :datetime
    add_column :manufacturers, :first_name, :string
    add_column :manufacturers, :middle_name, :string
    add_column :manufacturers, :business_name, :string
    add_column :manufacturers, :business_account_number, :string
    add_column :manufacturers, :start_date, :date
    add_column :manufacturers, :end_date, :date
    add_column :manufacturers, :end_reason_type_code, :integer
    add_column :manufacturers, :end_reason_item_code, :integer
    add_column :manufacturers, :end_reason_notes, :text
    add_column :manufacturers, :status_type_code, :integer
    add_column :manufacturers, :status_item_code, :integer
    add_column :manufacturers, :created_by, :integer
    add_column :manufacturers, :modified_by, :integer
    add_column :manufacturers, :created_at, :datetime,            null: false
    add_column :manufacturers, :updated_at, :datetime,            null: false
  end
end


