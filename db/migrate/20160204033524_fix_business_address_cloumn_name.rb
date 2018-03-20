class FixBusinessAddressCloumnName < ActiveRecord::Migration
  def change
    rename_column :business_addresses, :updated_by, :modified_by
  end
end
