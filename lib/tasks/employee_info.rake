task :employee_info_records => :environment do
  employees = Employee.all
  employees.each_with_index do|employee, index|
    if employee.employee_info.nil?
      employee.build_employee_info(employee_no: index + 1)
      employee.save
    end
  end
end
