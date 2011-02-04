class TaggingsController < ApplicationController

    #params skill_tags
    #e.g /taggings/skills_tags/ruby
    #    /taggings/skills_tags/ruby.json
    #    /taggings/skills_tags/ruby.xml


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

  def autocomplete
    #By now i haven't found how wildcard works on couch_db then we try with start and end_key
    #Employee.by_skill_tags( :startkey => 'ru' , :endkey => 'ruzzz',  :reduce => true, :group => true)

#    @employees =  Employee.send('by_' + params[:tags_type], {:startkey => params[:term] , :endkey => params[:term] + 'ZZZ',  :reduce => true, :group => true}).map{|t|  t.last}.flatten.map{ |t| t['key']}
    @tags =  Employee.send('by_' + params[:tags_type], { :reduce => true, :group => true}).map{|t|  t.last}.flatten.map{ |t| t['key']}

    respond_to do |format|
      format.json {render :json => @tags.to_json}
    end
  end

  def skill_tags_cloud
    #this method resolve the data needed in our skills tag graphic representation

    @tag_cloud = Employee.by_skill_tags(  :reduce => true, :group => true, :limit => 10)

    total_employee = Employee.count.to_f
    @tag_cloud['rows'].each{ |x| x['value'] = x['value'] / total_employee }
    respond_to do |format|
      format.json {render :json => @tag_cloud.to_json}
    end
  end

    #params
    #e.g /taggings/count/skill_tags
    #e.g /taggings/count/industry_tags
    #e.g /taggings/count/product_tags

  def tags_count
    #is the flat count of tags
    @tag_group = Employee.send('by_' + params[:tags_type],   :reduce => true, :group => true)
    respond_to do |format|
      format.json {render :json => @tag_group.to_json}
    end
  end

end

