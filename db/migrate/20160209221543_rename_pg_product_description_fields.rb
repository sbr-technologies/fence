class RenamePgProductDescriptionFields < ActiveRecord::Migration
  def change
    rename_column :pg_products, :project_group_product_description, :pg_product_description
    rename_column :pg_products, :project_group_product_long_description, :pg_product_long_description

  end
end
