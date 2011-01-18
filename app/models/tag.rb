require 'base_couch_document'

class Tag < BaseCouchDocument
  view_by :all_types,
    :map => "
      function(doc) {
        switch (doc['couchrest-type']) {
          case 'Tag':
          case 'IndustryTag':
            emit(doc['_id'], 1);
          default:
        }
      }
    "
  property :name
  property :type

end

