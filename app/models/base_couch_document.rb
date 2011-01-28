#required libraries - only used for irb console
#require 'rubygems'
#require 'couchrest'

class BaseCouchDocument < CouchRest::Model::Base
  use_database CouchServer.default_database    #this is configured in the config/initializers/couchdb.rb
end