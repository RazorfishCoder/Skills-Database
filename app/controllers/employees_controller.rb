class EmployeesController < ApplicationController
  before_filter :find_employee, :only => [:show, :edit, :update, :resume]
  def index
    @employees = Employee.all
  end

  def show
  end

  def edit
  end

  def update
    if params[:resume]
      @employee.store_resume(params[:resume].tempfile, params[:resume].original_filename)
    end

    if @employee.update_attributes(params[:employee])
      redirect_to(@employee, :notice => 'Employee was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def resume
    send_data(@employee.resume_data, :filename => @employee.resume)
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  end
end

