require 'couchrest/model'
# CouchServer = CouchRest::Server.new # defaults to localhost:5984
# Define which CouchDB instance to use.
# Creates the database if it does not exist already.
if ENV['CLOUDANT_URL']
    CouchServer = CouchRest::Server.new( ENV['CLOUDANT_URL'])
else
   CouchServer = CouchRest::Server.new( 'https://app374477.heroku:WUx2vEoX5EBgwcexBaI2kKq5@app374477.heroku.cloudant.com')
  #CouchServer = CouchRest::Server.new # defaults to localhost:5984
end
CouchServer.default_database = "skillsdb-#{Rails.env}"
