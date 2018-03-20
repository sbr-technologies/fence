class DropItemTypeCodeTables < ActiveRecord::Migration
  def change

    drop_table :lookup_item_codes
    drop_table :lookup_type_codes
  end
end
