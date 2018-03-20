#class EmployeeInfo < ActiveRecord::Base
#  has_paper_trail
#
#  monetize :hourly_rate, as: :hourly, allow_nil: true
#  monetize :gross_salary, as: :gross, allow_nil: true
#  monetize :taxes, as: :tax, allow_nil: true
#  monetize :net_salary, as: :net, allow_nil: true
#
#  belongs_to :employee
#
#  validates :employee_no, presence: true, uniqueness: {scope: :business_id}
#  validates :hourly, :hourly_rate, numericality: true, if: Proc.new{|e| e.hourly_rate.present?}
#  validates :gross, :gross_salary, numericality: true, if: Proc.new{|e| e.gross_salary.present?}
#  validates :tax, :taxes, numericality: true, if: Proc.new{|e| e.taxes.present?}
#  validates :net, :net_salary, numericality: true, if: Proc.new{|e| e.net_salary.present?}
#  validates_with EndAfterStartValidator
#
#end
