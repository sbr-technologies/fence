class CustomerContactPerson < ActiveRecord::Base
  STATUS = 'Customer Contact Status'
  CONTACT_TYPE = 'Customer Contact Type'
  belongs_to :business
  belongs_to :customer
  
  after_initialize :init
  
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def self.contact_type_code
    LookupTypeCode.find_by_description(CONTACT_TYPE)
  end
  
  def init
    self.status_type_code ||= self.class.status_type.id
    self.contact_type_code ||= self.class.contact_type_code.id
  end
end
