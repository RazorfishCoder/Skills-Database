class TaggingsController < ApplicationController

  def tag_query
    #params skill_tags
    #e.g /taggings/product_tags/ruby
    #    /taggings/product_tags/ruby.json
    #    /taggings/product_tags/ruby.xml


    #params product_tags
    #e.g /taggings/product_tags/cms
    #    /taggings/product_tags/cms.json
    #    /taggings/product_tags/cms.xml

    #params industry_tags
    #e.g /taggings/industry_tags/chemicals
    #    /taggings/industry_tags/chemicals.json
    #    /taggings/industry_tags/chemicals.xml
  def tag_query
    @employees = Employee.send('by_' + params[:tags_type], :key => params[:tag_name])
    respond_to do |format|
      format.json {render :json => @employees.to_json}
      format.xml {render :xml => @employees.to_xml}
      format.html {render 'employees/index'}
    end
  end

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

