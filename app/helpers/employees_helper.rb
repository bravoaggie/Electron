module EmployeesHelper
  def employee_main_path(employee)
    "/employees/main/" + employee.id
  end
end
