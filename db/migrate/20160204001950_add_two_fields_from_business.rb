class AddTwoFieldsFromBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :created_at, :datetime,            null: false
    add_column :businesses, :updated_at, :datetime,            null: false
  end
end
