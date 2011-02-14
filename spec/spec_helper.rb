# This file is copied to spec/ when you run 'rails generate rspec:install'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'couchrest/model'

# Ensure we're in the test environment and hence using the test database
ENV["RAILS_ENV"] ||= 'test'

# Creates the fixture path as well as sets up the test database connection to couch
unless defined?(FIXTURE_PATH)
  # Setup fixture and temp scratch paths
  FIXTURE_PATH = File.join(File.dirname(__FILE__), '/fixtures')
  SCRATCH_PATH = File.join(File.dirname(__FILE__), '/tmp')

  # Test CouchDB connection
  TestDatabaseName = "skillsdb-#{Rails.env}"
  CouchServer.default_database = TestDatabaseName
end

# Set's up the initial base couch document so it will use the test couch server connection
# TODO: This might need to be moved into the fixtures folder?  It would be great to re-use
# what we we already have setup in our /apps/models classes. 
class BaseCouchDocument < CouchRest::Model::Base
  use_database CouchServer.default_database    #this is same class configured in the config/initializers/couchdb.rb
end

# Reset/Recreate the couch db test database - used after each run spec run through
def reset_test_db!
  CouchServer.recreate! rescue nil
  CouchServer
end

# RSpec configuration for setup and tear-down after each spec run through.  This just ensures our 
# CouchDB test database is created before we run our tests and deleted when it's done.
RSpec.configure do |config|
  config.before(:all) { reset_test_db! }
  
  config.after(:all) do
    cr = CouchServer
    test_dbs = cr.databases.select { |db| db =~ /^#{TestDatabaseName}/ }
    test_dbs.each do |db|
      cr.database(db).delete! rescue nil
    end
  end
end

