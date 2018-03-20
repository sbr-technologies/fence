class RenameProductDescriptionFields < ActiveRecord::Migration
  def change
    rename_column :products, :product_description, :description
    rename_column :products, :product_long_description, :long_description

  end
end
