class FixSuppliersTable < ActiveRecord::Migration
  def change
    remove_column :suppliers, :name, :string
    remove_column :suppliers, :start_date, :date
    remove_column :suppliers, :end_date, :date
    remove_column :suppliers, :status, :string
    remove_column :suppliers, :created_at, :datetime
    remove_column :suppliers, :updated_at, :datetime
    remove_column :suppliers, :end_reason, :text
    add_column :suppliers, :name, :string
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

