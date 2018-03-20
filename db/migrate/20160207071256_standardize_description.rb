class StandardizeDescription < ActiveRecord::Migration
  def change
    rename_column :lookup_item_codes, :desc, :description
    rename_column :lookup_item_codes, :long_desc, :long_description
    rename_column :lookup_type_codes, :desc, :description
    rename_column :lookup_type_codes, :long_desc, :long_description
  end
end
