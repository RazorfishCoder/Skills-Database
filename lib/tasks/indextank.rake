require 'yaml'
require 'erb'
require 'indextank'
require File.dirname(__FILE__) + "/../../config/environment"

namespace :indextank do
  
  desc "Creates a new index"
  task :create do
    puts "Creating index '#{INDEXTANK_INDEX_NAME}' on '#{INDEXTANK_API_URL}'"
    EmployeeIndexer.create_index
  end
  
  desc "Deletes the index"
  task :delete do
    puts "Deleting index '#{INDEXTANK_INDEX_NAME}' on '#{INDEXTANK_API_URL}'"
    EmployeeIndexer.delete_index
  end
  
  desc "Recreates the index"
  task :recreate => [:delete] do
    puts "Recreating index '#{INDEXTANK_INDEX_NAME}' on '#{INDEXTANK_API_URL}'"
    Rake::Task['indextank:create'].invoke
  end
  
  desc "Reindex documents within the index"
  task :reindex => [:recreate] do
    puts "Reindexing documents for index '#{INDEXTANK_INDEX_NAME}' on '#{INDEXTANK_API_URL}'"
    @employees = Employee.all
    puts "About to index #{@employees.length} employees"
    @employees.each do |employee|
      EmployeeIndexer.add_document(employee)
    end
  end
    
end


