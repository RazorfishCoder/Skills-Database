# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rr'
require 'rspec/rails'

require 'rspec/core'
require 'rspec/expectations'

require 'indextank'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

FIXTURE_PATH = File.join(File.dirname(__FILE__), '/fixtures')
TESTDBNAME = "skillsdb-#{Rails.env}"

# RSpec configuration for setup and tear-down after each spec run through.  This just ensures our
# CouchDB test database is created before we run our tests and deleted when it's done.
RSpec.configure do |config|
  config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before(:all) do
    #Load linkedin api keys
    Linkedin.create(:api_key => 'eA_Uz2aQ8XlzEmiQv5zEcvcM3HYm-PYUghlJTir3FSC9L_Wbq8At_9kSpnj1lZQx', :secret_key => 'g2n_LE5xH3Mr1Repvki_imIO7LqvrIfcqwCOCdQRxBJ3JTto434BC3SR8fgijIrT')
  end

  # Reset/Recreate the couch db test database - used after each run spec run through
  config.after(:all) do
    cr = CouchServer
    test_dbs = cr.databases.select { |db| db =~ /#{TESTDBNAME}/ }
    test_dbs.each do |db|
      cr.database(db).recreate! rescue nil
    end
  end
end

def stub_setup_connection
    stub(IndexTank).setup_connection(anything) do |url|
      Faraday::Connection.new(:url => url) do |builder|
         builder.adapter :test, stubs
         builder.use Faraday::Response::Yajl
      end
    end
end

