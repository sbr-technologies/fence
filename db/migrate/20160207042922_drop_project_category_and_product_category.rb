class DropProjectCategoryAndProductCategory < ActiveRecord::Migration
  def change

    drop_table :product_categories
    drop_table :project_categories
  end
end
