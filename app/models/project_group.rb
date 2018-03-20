class ProjectGroup < ActiveRecord::Base
  CATEGORY = 'Project Category'
  STATUS = 'Project Group Status'
  belongs_to :business
  belongs_to :contract_proposal

  has_many :pg_products, dependent: :destroy
  has_many :products, through: :pg_products
  has_many :cp_project_groups

  validates :project_group_name, :business, presence: true
  
  after_initialize :init
  
  before_destroy :check_if_associated_with_contract_proposals
  
  default_scope { order('created_at DESC') }
  
  def self.category_type
    LookupTypeCode.find_by_description(CATEGORY)
  end
  
  def self.status_type
    LookupTypeCode.find_by_description(STATUS)
  end
  
  def init
    self.category_type_code ||= self.class.category_type.id
    self.status_type_code ||= self.class.status_type.id
  end
  
  def category
    LookupItemCode.find(self.category_item_code).description unless self.category_item_code.nil?
  end
  
  def status
    LookupItemCode.find(self.status_item_code).description unless self.status_item_code.nil?
  end
  
  def can_destroy?
    cp_project_groups.present?
  end

  def product_count
    self.pg_products.count
  end
  
  private
  
  def check_if_associated_with_contract_proposals
    if can_destroy?
      errors.add(:base, I18n.t('contract.errors.can_destroy'))
      return false
    end
  end
end
