class EmployeesController < ApplicationController
  before_filter :find_employee, :only => [:show, :edit, :update, :resume]
  def index
    @employees = Employee.all
  end

  def show
  end

  def edit
    @employee = Employee.find(params[:id])
    @skill_tags_names = @employee.skill_tags_names
    @industry_tags_names = @employee.industry_tags_names
    @product_tags_names = @employee.product_tags_names
  end

  def update
    if params[:resume]
      @employee.store_resume(params[:resume].tempfile, params[:resume].original_filename)
    end

#   need refactor
    @employee.skill_tags = []
    params["skill_tags"].split(", ").each{|tag| @employee.skill_tags << {:name => tag } }
    @employee.industry_tags = []
    params["industry_tags"].split(", ").each{|tag| @employee.industry_tags << {:name => tag } }
    @employee.product_tags = []
    params["product_tags"].split(", ").each{|tag| @employee.product_tags << {:name => tag } }

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

