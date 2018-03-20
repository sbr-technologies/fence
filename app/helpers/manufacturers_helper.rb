module ManufacturersHelper
  def manufacturer_status_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Manufacturer.status_type}).collect{|i| [i.description, i.id]}
  end

  def manufacturer_end_reason_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Manufacturer.end_reason_type}).collect{|i| [i.description, i.id]}
  end
end
