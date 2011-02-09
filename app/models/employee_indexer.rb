class EmployeeIndexer
  @@keys_to_index = ['first_name', 'last_name', 'job_title', 'industry', 'industry_tags', 'skill_tags', 'product_tags', 'email', 'professional_info', 'give_gets', 'interesting_facts', 'location', 'description' ]
  def self.index
     @api ||= IndexTank::Client.new(INDEXTANK_API_URL)
     @index ||= @api.indexes('test')
     #create_index unless @index.exists?

     @index
  end

  def self.create_index
    @index.add
    while not @index.running?
      puts 'waiting for index to start'
      sleep 1
    end
  end

  def self.search(query)
    # Searches over__any key 
    #@@keys_to_index.each do |value|
    #  query_to_search << "#{value}:(#{query})"
    #end
    index.search("__any:(#{query.to_s})")
  end

  def self.add_document(employee)
    filters = {}
    any = []
    employee.each do |name, value|
      unless !@@keys_to_index.include?(name) 
        filters[name] = value
        any << value if (!value.nil? and !value.empty?)
      end
    end
    filters[:__any] = any.join(" . ")
    index.document(employee.id).add(filters)
  end

  def self.load
  end
end
