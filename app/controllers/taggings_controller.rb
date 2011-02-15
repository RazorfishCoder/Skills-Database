class TaggingsController < ApplicationController


    #params skill_tags
    #e.g /taggings/skill_tags/ruby
    #    /taggings/skill_tags/ruby.json
    #    /taggings/skill_tags/ruby.xml


    #params product_tags
    #e.g /taggings/product_tags/cms
    #    /taggings/product_tags/cms.json
    #    /taggings/product_tags/cms.xml

    #params industry_tags
    #e.g /taggings/industry_tags/chemicals
    #    /taggings/industry_tags/chemicals.json
    #    /taggings/industry_tags/chemicals.xml

  def tag_query
    #bad behavior on will_paginate, its works but needs a review
    @employees = Employee.send('by_' + params[:tags_type], :key => params[:tag_name]).paginate :page => params[:page], :order => 'updated_at DESC',:per_page => 36

#    the position in the array indicates the group_by
#    @skills_groups[4] 80 - 100
#    @skills_groups[3] 60 - 80
#    @skills_groups[2] 40 - 60
#    @skills_groups[1] 20 - 40
#    @skills_groups[0] 0 - 20
    @skills_rate_groups = Employee.skill_rate_groups(params[:tag_name])
#    @skills_name_groups = [0,0,0,0,0]
    @skills_name_groups =  Employee.skill_names_group(params[:tag_name])
    @skills_name_groups = @skills_name_groups[0..9]

    @tag = params[:tag_name]

    respond_to do |format|

      format.json {render :json => @employees.to_json}
      format.xml {render :xml => @employees.to_xml}
      format.html {render 'skill_tag_show'}
#      format.html {render 'skill_tag_show'}

    end

  end

  def autocomplete

    #By now i haven't found how wildcard works on couch_db then we try with start and end_key
    #Employee.by_skill_tags( :startkey => 'ru' , :endkey => 'ruzzz',  :reduce => true, :group => true)

    #@employees =  Employee.send('by_' + params[:tags_type], {:startkey => params[:term] , :endkey => params[:term] + 'ZZZ',  :reduce => true, :group => true}).map{|t|  t.last}.flatten.map{ |t| t['key']}
    @tags =  Employee.send('by_' + params[:tags_type], { :reduce => true, :group => true}).map{|t|  t.last}.flatten.map{ |t| t['key']}

    respond_to do |format|
      format.json {render :json => @tags.to_json}
    end
  end

  def skill_tags_cloud
    #this method resolve the data needed in our skills tag graphic representation
    limit = params[:limit] || 100
    @tag_cloud = Employee.by_skill_tags(  :reduce => true, :group => true, :limit => limit)

    total_employee = Employee.count.to_f
    @tag_cloud['rows'].each{ |x| x['value'] = x['value'] / total_employee }
    respond_to do |format|
      format.json {render :json => @tag_cloud.to_json}
      format.html {render "employees/skills"}
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

