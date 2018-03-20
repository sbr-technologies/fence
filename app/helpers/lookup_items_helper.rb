module LookupItemsHelper
  def lookup_type_items
    LookupTypeCode.all.collect{|i| [i.description, i.id]}
  end
  
  def add_label label
    "Add #{label}"
  end
end