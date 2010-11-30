#required libraries - only used for irb console
#require 'rubygems'
#require 'couchrest'

# CouchDB Configuration
SERVER = CouchRest.new
DB     = SERVER.database!('skillsdatabase')

class BaseCouchDocument < CouchRest::Model::Base
  use_database DB
end