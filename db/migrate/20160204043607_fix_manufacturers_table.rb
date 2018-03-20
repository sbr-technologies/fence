class FixManufacturersTable < ActiveRecord::Migration
  def change
    remove_column :manufacturers, :number, :string
    remove_column :manufacturers, :name, :string
    remove_column :manufacturers, :start_date, :date
    remove_column :manufacturers, :end_date, :date
    remove_column :manufacturers, :end_reason, :text
    remove_column :manufacturers, :created_at, :datetime
    remove_column :manufacturers, :updated_at, :datetime
    add_column :manufacturers, :name, :string
    add_column :manufacturers, :number, :string
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

