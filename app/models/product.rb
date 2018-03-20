class Product < ActiveRecord::Base
  CATEGORY = 'Product Category'
  STATUS = 'Product Status'
  UOM = 'Unit of Measure'
  
  belongs_to :business
  belongs_to :manufacturer
  belongs_to :supplier, foreign_key: :preferred_supplier_id
  
  has_many :pg_products
  has_many :project_groups, through: :pg_products
  
  
  validates :product_sku, :product_name, :preferred_supplier_id, :manufacturer, :business, :category_item_code, :uom_item_code, :status_item_code, presence: true
  validates :product_sku, :product_name, uniqueness: { :scope => :business_id }

  validates :cost_price, :retail_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  validate :cost_price_is_less_or_equal_to_retail
  after_initialize :init
#  scope :active, lambda{ where(status_id: ACTIVE)}

  def self.category_type
    LookupTypeCode.find_by_description(CATEGORY)
  end
  
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def self.uom_type
    LookupTypeCode.find_by_description(UOM)
  end
  
  def init
    self.status_type_code ||= self.class.status_type.id
    self.category_type_code ||= self.class.category_type.id
    self.uom_type_code ||= self.class.uom_type.id
  end
  
  def unit_of_measure
    LookupItemCode.find(self.uom_item_code).description unless self.uom_item_code.nil?
  end
  
    
  def status
    LookupItemCode.find(self.status_item_code).description unless self.status_item_code.nil?
  end

  def can_destroy?
    pg_products.present?
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
  
  private
  
  def cost_price_is_less_or_equal_to_retail
    errors.add(:cost_price, I18n.t('product_rates.errors.cost_price')) if cost_price > retail_price
  end
  
end
