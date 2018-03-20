class FixCpPgProductsAndPgProductsTable < ActiveRecord::Migration
  def change


    remove_column :cp_pg_products, :status_type_code, :integer
    remove_column :cp_pg_products, :status_item_code, :integer
    remove_column :cp_pg_products, :created_by, :integer
    remove_column :cp_pg_products, :modified_by, :integer
    remove_column :cp_pg_products, :created_at, :datetime
    remove_column :cp_pg_products, :updated_at, :datetime

    add_column :cp_pg_products, :uom_type_code, :integer
    add_column :cp_pg_products, :uom_item_code, :integer
    add_column :cp_pg_products, :status_type_code, :integer
    add_column :cp_pg_products, :status_item_code, :integer
    add_column :cp_pg_products, :created_by, :integer
    add_column :cp_pg_products, :modified_by, :integer
    add_column :cp_pg_products, :created_at, :datetime,            null: false
    add_column :cp_pg_products, :updated_at, :datetime,            null: false

    remove_column :pg_products, :status_type_code, :integer
    remove_column :pg_products, :status_item_code, :integer
    remove_column :pg_products, :created_by, :integer
    remove_column :pg_products, :modified_by, :integer
    remove_column :pg_products, :created_at, :datetime
    remove_column :pg_products, :updated_at, :datetime

    add_column :pg_products, :uom_type_code, :integer
    add_column :pg_products, :uom_item_code, :integer
    add_column :pg_products, :status_type_code, :integer
    add_column :pg_products, :status_item_code, :integer
    add_column :pg_products, :created_by, :integer
    add_column :pg_products, :modified_by, :integer
    add_column :pg_products, :created_at, :datetime,            null: false
    add_column :pg_products, :updated_at, :datetime,            null: false

  end



end


