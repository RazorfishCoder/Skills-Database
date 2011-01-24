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

end

