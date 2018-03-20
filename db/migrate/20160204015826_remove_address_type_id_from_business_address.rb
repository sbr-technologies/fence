class RemoveAddressTypeIdFromBusinessAddress < ActiveRecord::Migration
  def change
    remove_column :business_addresses, :address_type_id, :integer
  end
end
