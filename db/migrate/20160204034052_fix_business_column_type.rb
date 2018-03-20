class FixBusinessColumnType < ActiveRecord::Migration
  def change
    change_column :businesses, :status_item_code, 'integer USING CAST(status_item_code AS integer)'
  end
end
