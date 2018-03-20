class DropUnitOfMeasurement < ActiveRecord::Migration
  def change
        remove_column :project_products, :unit_of_measurement_id, :integer
        remove_column :cp_pg_products, :uom_id, :integer
        remove_column :pg_products, :uom_id, :integer
        remove_column :products, :uom_id, :integer
        drop_table :unit_of_measurements 
  end
end
