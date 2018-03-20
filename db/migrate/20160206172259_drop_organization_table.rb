class DropOrganizationTable < ActiveRecord::Migration
  def change
    remove_column :project_products, :product_id, :integer
    drop_table :project_products
    drop_table :projects
    drop_table :contracts
    drop_table :organizations
  end
end
