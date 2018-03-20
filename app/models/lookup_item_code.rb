class LookupItemCode < ActiveRecord::Base
  belongs_to :business
  belongs_to :lookup_type_code
  
  validates :description, presence: true, uniqueness: { scope: [:business, :lookup_type_code]}
  
  before_destroy :check_if_has_association
  
#  def can_destroy?
#    product_statuses.present? || product_uoms.present? || product_categories.present? || pg_statuses.present? || pg_categories.present? || business_addr_statuses.present? || business_contact_statuses.present? || business_contact_types.present? || business_phone_types.present? || employee_statuses.present?
#  end
  
  def can_destroy?
    reject_array =  ['schema_migrations', 'versions', 'lookup_type_codes', 'lookup_item_codes', 'roles']
    tables = ActiveRecord::Base.connection.tables.reject{|a| reject_array.include? a}
    tables.each do |table|
      begin
        klass = table.singularize.camelize.constantize      
        if ActiveRecord::Base.connection.column_exists?(table, :status_type_code) && klass.exists?({:status_type_code => lookup_type_code_id, :status_item_code => id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :uom_type_code) && klass.exists?({:uom_type_code => lookup_type_code_id, :uom_item_code => id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :category_type_code) && klass.exists?({:category_type_code => lookup_type_code_id, :category_item_code => id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :end_reason_type_code) && klass.exists?({:end_reason_type_code => self.lookup_type_code_id, :end_reason_item_code => self.id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :phone_type_code) && klass.exists?({:phone_type_code => self.lookup_type_code_id, :phone_item_code => self.id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :employee_type_code) && klass.exists?({:employee_type_code => self.lookup_type_code_id, :employee_item_code => self.id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :contact_type_code) && klass.exists?({:contact_type_code => self.lookup_type_code_id, :contact_item_code => self.id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :cp_proposal_terms_item_code) && klass.exists?({:cp_proposal_terms_type_code => self.lookup_type_code_id, :cp_proposal_terms_item_code => self.id})
          return false
        elsif ActiveRecord::Base.connection.column_exists?(table, :cp_payment_terms_item_code) && klass.exists?({:cp_payment_terms_type_code => self.lookup_type_code_id, :cp_payment_terms_item_code => self.id})
          return false
        end
      rescue => ex
        logger.error "Error Class: #{ex.message}"
      end
    end
    return true
  end
  
  private
  
  def check_if_has_association
    can_destroy?
  end
end
