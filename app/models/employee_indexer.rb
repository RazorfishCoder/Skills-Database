class EmployeeIndexer
  # Define all the properties of Employee.rb that we want to index 
  @@keys_to_index = ['first_name', 'last_name', 'job_title', 'industry', 'picture_url', 'industry_tags', 'skill_tags', 'product_tags', 'email', 'professional_info', 'give_gets', 'interesting_facts', 'location', 'description' ]
  
  # Defines a property on class that represents our IndexTank's index
  def self.index
     @api ||= IndexTank::Client.new(INDEXTANK_API_URL)
     @index ||= @api.indexes(INDEXTANK_INDEX_NAME)
     @index
  end

  # Creates the IndexTank index - Currently being used by Rake Tasks for management of the index.  
  def self.create_index
    index.add
    while not index.running?
      puts 'waiting for index to start'
      sleep 1
    end
  end
  
  # Deletes this index - Currently being used by Rake Tasks for management of the index
  def self.delete_index
    index.delete
  end

  # Facilitates the searching of our index via IndexTank.  The query string passed in will 
  # search all text portion of our documents defined by the aggregation of our @@keys_to_index
  def self.search(query)
    # Searches over __any key 
    #@@keys_to_index.each do |value|
    #  query_to_search << "#{value}:(#{query})"
    #end
    index.search("__any:(#{query.to_s})")
  end
  
  def self.search_by_property(name, value)
    index.search("#{name}:(#{value})")
  end

  # Adds the Employee model to our index.  
  # This is called from the after_save filter within our Employee model as well as our Rake Tasks
  # This loops over each property within the employee and indexes each field.  It also appends 
  # our properties names into one giant string separated by '.' if we simply want to do a free text search
  def self.add_document(employee)
    filters = {}
    any = []
    employee.each do |name, value|
      unless !@@keys_to_index.include?(name) 
        value = value.join "," if value.kind_of?(Array)
        if (!value.nil? and !value.empty?)
          filters[name] = value
          any << value
        end
      end
    end
    filters[:__any] = any.join(" . ")
    index.document(employee.id).add(filters)
  end

end
