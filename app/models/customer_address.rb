class CustomerAddress < ActiveRecord::Base
  belongs_to :business
  belongs_to :customer
  
  after_initialize :init
  
  def init
    self.status_type_code ||= LookupTypeCode.address_status_type.id
    self.address_type_code ||= LookupTypeCode.address_type_code.id
    
    self.status_item_code ||= LookupItemCode.find_by(lookup_type_code_id: self.status_type_code).id
    self.address_item_code ||= LookupItemCode.find_by(lookup_type_code_id: self.address_type_code).id
  end
end
