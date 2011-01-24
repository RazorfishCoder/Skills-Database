require 'BaseCouchDocument'

class Employee < BaseCouchDocument
  
  #############
  # Properties
  #############  
  property :linkedin_id    
  property :first_name
  property :last_name
  property :last_name, :alias => :family_name  #playing around with aliases
  property :job_title  #headline
  property :industry
  property :linkedin_url
  property :picture_url
  property :phone_number
  property :email
  property :tags, [Tag], :cast_as => 'Tag'
  timestamps!
  
  #############
  # Views
  #############
  view_by :updated_at, :descending => true
  view_by :linkedin_id
  view_by :latest_updates
  view_by :id
  view_by :first_name
  view_by :email
   
  view_by :tags, :map => "
    function(doc) {
      if(doc['couchrest-type'] == 'Employee' && doc['tags'] != null && doc.tags.length > 0){
          for(var tag in doc.tags) {
              emit(doc.tags[tag].name, {first_name: doc.first_name, last_name: doc.last_name});
          }
        } 
      }
  "
  
  #############
  # Validations
  #############
  validates_uniqueness_of :linkedin_id
  validates_uniqueness_of :email
  
end
