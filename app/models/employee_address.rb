class EmployeeAddress < ActiveRecord::Base
  belongs_to :business
  belongs_to :employee
end
