class FixLastNameSuppliersManufacturers < ActiveRecord::Migration
  def change
    rename_column :manufacturers, :lastname, :last_name
    rename_column :suppliers, :lastname, :last_name

  end
end
