class Customer < ActiveRecord::Base
  STATUS = 'Customer Status'
  END_REASON = 'Customer End Reason'
  
  belongs_to :business

  has_many :contract_proposals
  has_many :addresses, :class_name => 'CustomerAddress', dependent: :destroy
  has_many :phones, :class_name => 'CustomerPhone', dependent: :destroy
  has_many :contact_persons, :class_name => 'CustomerContactPerson', dependent: :destroy
  
  
  validates :first_name, :last_name, presence: true, if: Proc.new{|c| c.business_name.blank?}
  validates :business_name, presence: true, 
                   uniqueness: {scope: :business_id, :case_sensitive => false}, 
                   if: Proc.new{|c| c.first_name.blank? and c.last_name.blank? }
  validates :margin_percent, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 99.99}
  validate :validate_single_primary
  validates_length_of :middle_initial, maximum: 1, allow_blank: true
  validates_with EndAfterStartValidator
  accepts_nested_attributes_for :addresses, :phones, :contact_persons, allow_destroy: true
  
  after_initialize :init
  before_destroy :check_if_associated_with_contract_proposals
    
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def self.end_reason_type
    LookupTypeCode.find_by_description(END_REASON)
  end
  
  def init
    self.status_type_code ||= self.class.status_type.id
    self.end_reason_type_code ||= self.class.end_reason_type.id
  end
  
  def status
    LookupItemCode.find(self.status_item_code).description unless self.status_item_code.nil?
  end
  
  def name_format
    business_name.present? ? business_name : "#{last_name}, #{first_name}"
  end

  def get_name
    business_name.present? ? business_name : "#{last_name} #{first_name} #{middle_initial}".strip
  end

  def name
    business_name.present? ? business_name : "#{last_name} #{first_name} #{middle_initial}".strip
  end
  
  def start_date_text
    start_date.to_s
  end

  def can_destroy?
    contract_proposals.present?
  end
  
  def self.valid_attribute?(id, attr, value)
    if id.blank?
      mock = self.new(attr => value)
    else
      mock = self.find(id)
      mock.assign_attributes(attr => value)
    end
    if mock.valid?
      true
    else
      mock.errors[attr].blank?
    end
  end
  
  def primary_address
    self.addresses.where(is_primary: true).first
  end
      

  private

  def validate_single_primary
    validate_single_primary_in_memory_for(addresses)
  end

  def check_if_associated_with_contract_proposals
    if can_destroy?
      errors.add(:base, I18n.t('contract.errors.can_destroy'))
      return false
    end
  end
end
