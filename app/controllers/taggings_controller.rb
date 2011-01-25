class TaggingsController < ApplicationController

  def skill_tags_cloud
   @tag_cloud = Employee.by_skill_tags(  :reduce => true, :group => true)
    respond_to do |format|
      format.json {render :json => @tag_cloud.to_json}
    end
  end

  def product_tags_cloud
   @tag_cloud = Employee.by_product_tags(  :reduce => true, :group => true)
    respond_to do |format|
      format.json {render :json => @tag_cloud.to_json}
    end
  end

  def industry_tags_cloud
   @tag_cloud = Employee.by_industry_tags(  :reduce => true, :group => true)
    respond_to do |format|
      format.json {render :json => @tag_cloud.to_json}
    end
  end

  def skill_tags
    @employees = Employee.by_skill_tags( :key => params[:tag_name])
    respond_to do |format|
      format.json {render :json => @employees.to_json}
      format.xml {render :xml => @employees.to_xml}
      format.html {render 'employees/index'}
    end
  end

  def product_tags
    @employees = Employee.by_product_tags( :key => params[:tag_name])
    respond_to do |format|
      format.json {render :json => @employees.to_json}
      format.xml {render :xml => @employees.to_xml}
      format.html {render 'employees/index'}
    end
  end

  def industry_tags
    @employees = Employee.by_industry_tags( :key => params[:tag_name])
    respond_to do |format|
      format.json {render :json => @employees.to_json}
      format.xml {render :xml => @employees.to_xml}
      format.html {render 'employees/index'}
    end
  end


end

