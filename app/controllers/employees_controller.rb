class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end
  def show
    @employee = Employee.find(params[:id])
  end
  def edit
    @employee = Employee.find(params[:id])
  end
  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(params[:employee])
        redirect_to(@employee, :notice => 'Employee was successfully updated.') 
      else
        render :action => "edit" 
      end
  end
end
