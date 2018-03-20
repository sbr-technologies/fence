class RemoveFieldsFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :biz_name, :string
    remove_column :businesses, :license_nmbr, :string
    remove_column :businesses, :status_id, :integer
    remove_column :businesses, :created_by, :integer
    remove_column :businesses, :updated_by, :integer
  end
end
