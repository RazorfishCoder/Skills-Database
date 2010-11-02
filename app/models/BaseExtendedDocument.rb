require 'rubygems'
require 'couchrest'

SERVER = CouchRest.new
DB     = SERVER.database!('skillsdatabase')

class BaseExtendedDocument < CouchRest::ExtendedDocument
  use_database DB
end