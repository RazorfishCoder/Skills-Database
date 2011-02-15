class BaseFixture < CouchRest::Model::Base
  
  use_database CouchServer.default_database

end