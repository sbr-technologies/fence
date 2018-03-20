class RemoveBusinessFromLookupTypeCode < ActiveRecord::Migration
  def change
    remove_reference :lookup_type_codes, :business, index: true
  end
end
