module EmployeesHelper
  def non_editable_employee_field(fieldname)
    content_tag(:span, @employee.send(fieldname), :class=>"noneditable-field" )
  end
end
