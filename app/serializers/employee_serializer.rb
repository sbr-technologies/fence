class EmployeeSerializer < ActiveModel::Serializer
  attributes :employee_number, :id, :last_name, :first_name, :name, :middle_initial, :can_destroy?
end