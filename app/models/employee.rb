class Employee < BaseCouchDocument

  #############
  # Properties
  #############
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
  property :resume
  timestamps!

  #############
  # Views
  #############
  view_by :first_name, :last_name
  view_by :updated_at, :descending => true
  view_by :id

  view_by :tags, :map => "
    function(doc) {
      if(doc['couchrest-type'] == 'Employee' && doc['tags'] != null && doc.tags.length > 0){
          for(var tag in doc.tags) {
              emit(doc.tags[tag].name, {first_name: doc.first_name, last_name: doc.last_name});
          }
        }
      }"

  ################
  # class Methods
  ################
  def self.create_from_hash!(hash)
    if hash['user_info'][:last_job].match(/Razorfish|Globant|Selfemployed/)
      self.create(hash['user_info'][:employee])
    else
      return false
    end
  end

  ################
  # public Methods
  ################

  def resume_data
    self.read_attachment(self.resume)
  end

  def store_resume(file, filename)
    self.create_attachment({:file => file , :name => filename})
    self.resume = filename
  end

end

