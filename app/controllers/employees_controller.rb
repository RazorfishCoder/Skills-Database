class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end
  def show
    @employee = Employee.find(params[:id])
  end
  def edit
    @employee = Employee.find(params[:id])
    @skill_tags_names = @employee.skill_tags_names
    @industry_tags_names = @employee.industry_tags_names
    @product_tags_names = @employee.product_tags_names

  end
  def update
    @employee = Employee.find(params[:id])

    @employee.skill_tags = SkillTag.bulk_create(params["skill_tags"] )
    @employee.industry_tags = IndustryTag.bulk_create(params["industry_tags"] )
    @employee.product_tags =  ProductTag.bulk_create(params["product_tags"])

    if @employee.update_attributes(params[:employee])
        redirect_to(@employee, :notice => 'Employee was successfully updated.')
      else
        render :action => "edit"
      end
  end
end

