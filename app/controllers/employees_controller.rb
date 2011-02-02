class EmployeesController < ApplicationController
  before_filter :find_employee, :only => [:show, :edit, :update, :resume]
  before_filter :validate_current_user, :only => [:edit, :update]

  def show
  end

  def edit

    @skill_tags_names = @employee.skill_tags_names
    @industry_tags_names = @employee.industry_tags_names
    @product_tags_names = @employee.product_tags_names

  end

  def update
    if params[:resume]
      @employee.store_resume(params[:resume].tempfile, params[:resume].original_filename)
    end

    #TODO need refactor
    @employee.skill_tags = []
#    params[employee"skill_tags"].each{|tag| @employee.skill_tags << {:name => tag.name.downcase, :rate => tag.rate } }
    @employee.industry_tags = []
    params["industry_tags"].split(", ").each{|tag| @employee.industry_tags << {:name => tag.downcase } }
    @employee.product_tags = []
    params["product_tags"].split(", ").each{|tag| @employee.product_tags << {:name => tag.downcase } }

    if @employee.update_attributes(params[:employee])
      redirect_to(root_path, :notice => 'Employee was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def resume
    send_data(@employee.resume_data, :filename => @employee.resume)
  end

  private

  def find_employee
    @employee = Employee.find_by_permalink(params[:id])
  end

  def validate_current_user
    redirect_to root_path, :notice => "You don't have permission to complete this task" unless @employee == current_user
  end
end

