class EmployeesController < ApplicationController
  before_filter :find_employee, :only => [:show, :edit, :update, :resume, :bio]
  before_filter :validate_current_user, :only => [:edit, :update]

  def show
  end

  def edit

    @skill_tags_names = @employee.skill_tags_names
    @industry_tags_names = @employee.industry_tags_names
    @product_tags_names = @employee.product_tags_names

  end

  def update
    @employee.store_resume(params[:resume].tempfile, params[:resume].original_filename) if params[:resume]
    @employee.store_bio(params[:bio].tempfile, params[:bio].original_filename) if params[:bio]

    #TODO need refactor
    @employee.skill_tags = []
#    params[:employee]["skill_tags"].each{|tag| @employee.skill_tags << {:name => tag.name.downcase, :rate => tag.rate } }
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

  def search
    # Search index based on query
    @index_results = EmployeeIndexer.search(params[:query]) if params[:query]
    
    # Save the search query in couch
    @search = Search.new(:employee => self.current_user, :search => params[:query])
    if !@search.save
      raise "Error saving search"
    end

    # Search DB based on index results.
    @ids = []
    @index_results['results'].each { |doc| @ids << doc['docid'] }
    @results = []
    #by now I'm hitting the DB one by one. I haven't found a better way yet.
    @ids.each do |id| 
      @results << Employee.find(id)
    end
    @matches = @results.compact.count
    @results.compact!
    
    # Create has set of skills, locations, products, industry - TODO: Move this to couchdb map/reduce!!!!
    @skills_filter = []
    @results.collect(&:skill_tags).each do |skill_tag| 
      skill_tag.each do |skill|
        @skills_filter << skill.name.downcase
      end
    end 
    
    @products_filter = []
    @results.collect(&:product_tags).each do |product_tag|
      product_tag.each do |product|
        @products_filter << product.name.downcase
      end
    end
    
    @industry_filter = []
    @results.collect(&:industry_tags).each do |industry_tag|
      industry_tag.each do |industry|
        @industry_filter << industry.name.downcase
      end
    end
    
    @locations_filter = @results.collect(&:location).uniq.compact
    @skills_filter.uniq!
    @products_filter.uniq!
    @industry_filter.uniq!    
    
    # Paginate the search results
    @results = @results.paginate(:page => params[:page], :per_page => 3)  
    
  end
  
  def bio
    send_data(@employee.bio_data, :filename => @employee.bio)
  end
  
  private

  def find_employee
    @employee = Employee.find_by_permalink(params[:id])
    
    # Increment the view counter to track 'most viewed' employees
    if (@employee && @employee != current_user)
      @employee.update_attributes(:num_views => @employee.num_views + 1)
    end
    
    @similar_employees = []
    # find similar employees to the one we're viewing
    if (@employee && @employee.skill_tags && !@employee.skill_tags.empty?)
      @skill_tag_query = ""
      @employee.skill_tags.each_with_index do |tag, index| 
        @skill_tag_query << tag.name
        if (index < @employee.skill_tags.length - 1)
          @skill_tag_query << " OR "
        end
      end
      
      # Copied from the search method above...there's gotta be a better way to pull these folks.
      @similar_employees_results = EmployeeIndexer.search(@skill_tag_query) if @skill_tag_query
      @ids = []
      @similar_employees_results['results'].each { |doc| @ids << doc['docid'] }
      @ids.each do |id| 
        @similar_employees << Employee.find(id) unless (id == @employee.id)
      end
      @similar_employees.compact!
    end
    
  end

  def validate_current_user
    redirect_to root_path, :notice => "You don't have permission to complete this task" unless @employee == current_user
  end
end

