class PgProduct < ActiveRecord::Base
  STATUS = 'Project Group Product Status'
  monetize :labor_cost, as: :labor
  
  belongs_to :business
  belongs_to :project_group
  belongs_to :product
  
  validates :product_id, presence: true
  validates :quantity, :labor_cost, :labor_hours, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :project_group_id, :scope => [:product_id]
  after_initialize :init
  
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def init
    self.status_type_code ||= self.class.status_type.id
    self.uom_type_code ||= self.product.class.uom_type.id
    
    self.status_item_code ||= self.project_group.status_item_code
    self.quantity  ||= 0
    self.labor_cost  ||= 0
    self.labor_hours  ||= 0
    self.created_by ||= self.project_group.created_by
    self.modified_by = self.project_group.modified_by
  end
  
end
