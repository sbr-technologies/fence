class Supplier < ActiveRecord::Base
  STATUS = 'Supplier Status'
  END_REASON = 'Supplier End Reason'
  belongs_to :business
  has_many :products, :foreign_key => :preferred_supplier_id
#  has_many :contacts, as: :contactable, dependent: :destroy

  has_many :addresses, :class_name => 'SupplierAddress', dependent: :destroy
  has_many :phones, :class_name => 'SupplierPhone', dependent: :destroy
  has_many :contact_persons, :class_name => 'SupplierContactPerson', dependent: :destroy
  
  validates :status_item_code, presence: true
  validates :first_name, :last_name, presence: true, if: Proc.new{|c| c.business_name.blank?}
  validates :business_name, presence: true, 
                   uniqueness: {scope: :business_id}, 
                   if: Proc.new{|c| c.first_name.blank? and c.last_name.blank? }
  validates_length_of :middle_initial, maximum: 1, allow_blank: true
#  accepts_nested_attributes_for :addresses, :phones, :contacts, allow_destroy: true
  accepts_nested_attributes_for :addresses, :phones, :contact_persons, allow_destroy: true
  validates_with EndAfterStartValidator
#  validate :validate_single_primary
  after_initialize :init
#  scope :by_business, -> (org_id) { where( business_id: org_id)}
  before_destroy :check_if_associated_with_products
  
  def name
    business_name.present? ? business_name : "#{last_name} #{first_name} #{middle_initial}".strip
  end



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
  
  def can_destroy?
    products.present?
  end
  
  private

  def check_if_associated_with_products
    if can_destroy?
      errors.add(:base, I18n.t('supplier.errors.can_destroy'))
      return false
    end
  end
# Bart commented out 2-6-2015
#  def validate_single_primary
#    validate_single_primary_in_memory_for(phones)
#    validate_single_primary_in_memory_for(addresses)
#    validate_single_primary_in_memory_for(contacts)
#  end
end
