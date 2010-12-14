require 'couchrest/model'
#CouchServer = CouchRest::Server.new # defaults to localhost:5984
# Define which CouchDB instance to use.
# Creates the database if it does not exist already.
if ENV['CLOUDANT_URL']
  CouchServer = CouchRest.database!( ENV['CLOUDANT_URL'] + ENV['APP_NAME'] )
else
  CouchRest::Server.new # defaults to localhost:5984
  CouchServer.default_database = "skillsdb-#{Rails.env}"
end
