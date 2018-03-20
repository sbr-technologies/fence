class RemoveTwoFieldsFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :created_at, :datetime
    remove_column :businesses, :updated_at, :datetime
  end
end
