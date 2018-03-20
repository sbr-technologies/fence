module CustomersHelper
  def customer_status_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Customer.status_type}).collect{|i| [i.description, i.id]}
  end
  
  def customer_end_reason_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Customer.end_reason_type}).collect{|i| [i.description, i.id]}
  end
end
