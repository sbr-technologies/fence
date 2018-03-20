module EmployeeHelper
  def cannot_set_need_login?
    return false if @employee.new_record?
    (current_employee == @employee) || @employee.is_enterprise_admin?
  end
  
  
  def employee_status_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Employee.status_type}).collect{|i| [i.description, i.id]}
  end

  def employee_end_reason_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Employee.end_reason_type}).collect{|i| [i.description, i.id]}
  end

  def employee_type_items
    @business.lookup_item_codes.where({:lookup_type_code_id => Employee.employee_type}).collect{|i| [i.description, i.id]}
  end
  
end
