class FixProjectGroupProducts < ActiveRecord::Migration
  def change
    remove_column :pg_products, :status_id, :integer
    remove_column :pg_products, :created_by, :integer
    remove_column :pg_products, :updated_by, :integer
    remove_column :pg_products, :created_at, :datetime
    remove_column :pg_products, :updated_at, :datetime
    add_column :pg_products, :status_type_code, :integer 
    add_column :pg_products, :status_item_code, :integer 
    add_column :pg_products, :created_by, :integer
    add_column :pg_products, :modified_by, :integer
    add_column :pg_products, :created_at, :datetime,            null: false
    add_column :pg_products, :updated_at, :datetime,            null: false

  end
end

