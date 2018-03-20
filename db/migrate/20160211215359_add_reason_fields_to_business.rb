class AddReasonFieldsToBusiness < ActiveRecord::Migration
  def change

    remove_column :businesses, :created_by, :integer
    remove_column :businesses, :modified_by, :integer
    remove_column :businesses, :created_at, :datetime
    remove_column :businesses, :updated_at, :datetime

    add_column :businesses, :start_date, :date
    add_column :businesses, :end_date, :date
    add_column :businesses, :end_reason_type_code, :integer
    add_column :businesses, :end_reason_item_code, :integer
    add_column :businesses, :end_reason_notes, :text
    add_column :businesses, :created_by, :integer
    add_column :businesses, :modified_by, :integer
    add_column :businesses, :created_at, :datetime,            null: false
    add_column :businesses, :updated_at, :datetime,            null: false
  end
end

