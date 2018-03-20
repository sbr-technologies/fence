class LookupTypeCode < ActiveRecord::Base
  ADDRESS_STATUS = 'Address Status'
  ADDRESS_TYPE = 'Address Type'
  PHONE_STATUS = 'Phone Status'
  PHONE_TYPE = 'Phone Type'
  EMAIL_TYPE = 'Email Type'
  has_many :lookup_item_codes
  
  def self.address_status_type
    self.find_by_description(ADDRESS_STATUS)
  end
  
  def self.address_type_code
    self.find_by_description(ADDRESS_TYPE)
  end
  
  def self.phone_status_type
    self.find_by_description(PHONE_STATUS)
  end
  
  def self.phone_type_code
    self.find_by_description(PHONE_TYPE)
  end
  
  def self.email_type_code
    self.find_by_description(EMAIL_TYPE)
  end
end
