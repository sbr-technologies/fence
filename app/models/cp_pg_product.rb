class CpPgProduct < ActiveRecord::Base
  STATUS = 'Proposal Project Group Product Status'
  belongs_to :business
  belongs_to :cp_project_group
  belongs_to :project_group
  belongs_to :product

  after_initialize :init
  
  
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def init
    self.status_type_code ||= self.class.status_type.id
    self.status_item_code ||= self.cp_project_group.status_item_code
    self.uom_type_code ||= self.product.class.uom_type.id
    self.quantity  ||= 0
    self.labor_cost  ||= 0
    self.labor_hours  ||= 0
    
    self.created_by ||= self.cp_project_group.created_by
    self.modified_by = self.cp_project_group.modified_by
  end
  
  def total_amount
    retail_price * quantity + labor_hours * labor_cost
  end
  
#bart commented out 2-6-2016
#  before_create :set_default_values
#  
#  def set_default_values
#    self.status_id ||= self.business.statuses.first.id
#  end
end