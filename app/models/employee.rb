require 'base_couch_document'

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
  property :tags, [String]
  #property :address, :cast_as => 'Address'    #playing around with associations
  property :phone_number
  property :email
  property :resume
  timestamps!

  #############
  # Views
  #############
  #view_by :last_name, :first_name
  view_by :updated_at, :descending => true
  view_by :linkedin_id
  view_by :latest_updates
  view_by :id
  view_by :product_code, :map => "
    function(doc) {
      if (doc['couchrest-type'] == 'Product' || doc['couchrest-type'] == 'Project') {
        emit(doc['code']);
      }
    }
  "

  #############
  # Validations
  #############
  validates_uniqueness_of :linkedin_id

  def resume_data
    self.read_attachment(self.resume)
  end

  def store_resume(file, filename)
    self.create_attachment({:file => file , :name => filename})
    self.resume = filename
  end
end

