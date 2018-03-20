class RenameProductProjectGroupCategory < ActiveRecord::Migration
  def change
    rename_column :products, :product_category_type_code, :category_type_code
    rename_column :products, :product_category_item_code, :category_item_code
    rename_column :project_groups, :project_category_type_code, :category_type_code
    rename_column :project_groups, :project_category_item_code, :category_item_code
  end
end
