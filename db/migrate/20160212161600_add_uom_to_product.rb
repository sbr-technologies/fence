class AddUomToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :status_type_code, :integer 
    remove_column :products, :status_item_code, :integer 
    remove_column :products, :created_by, :integer
    remove_column :products, :modified_by, :integer
    remove_column :products, :created_at, :datetime
    remove_column :products, :updated_at, :datetime

    add_column :products, :uom_type_code, :integer
    add_column :products, :uom_item_code, :integer
    add_column :products, :status_type_code, :integer 
    add_column :products, :status_item_code, :integer 
    add_column :products, :created_by, :integer
    add_column :products, :modified_by, :integer
    add_column :products, :created_at, :datetime,            null: false
    add_column :products, :updated_at, :datetime,            null: false
  end
end
