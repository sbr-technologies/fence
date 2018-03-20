class FixBusinessCloumnName < ActiveRecord::Migration
  def change
    rename_column :businesses, :updated_by, :modified_by
  end
end
