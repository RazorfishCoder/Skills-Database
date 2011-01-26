class Employee < BaseCouchDocument
  include Memories

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
  property :permalink

  timestamps!

  #############
  # Views
  #############
  view_by :first_name, :last_name
  view_by :updated_at, :descending => true
  view_by :id
  view_by :permalink

  view_by :tags, :map => "
    function(doc) {
      if(doc['couchrest-type'] == 'Employee' && doc['tags'] != null && doc.tags.length > 0){
          for(var tag in doc.tags) {
              emit(doc.tags[tag].name, {first_name: doc.first_name, last_name: doc.last_name});
          }
        }
      }"

  ################
  # Observers
  ################
  before_save :generate_permalink

  def generate_permalink
    self.permalink ||= self.full_name.parameterize
  end

  after_save :extract_differences

  def extract_differences
    useless_properties = ['created_at', 'updated_at']

    if self.current_version == 1
      EmployeeEvent.create(:employee => self, :event_type => 'new_employee')
    else
      previous_instance = self.versions[self.previous_version].instance
      changes = []

      self.properties.reject{|property| useless_properties.include? property.to_s}.each do |property|
        changes << property unless self[property] == previous_instance[property]
      end

      EmployeeEvent.create(:employee => self, :changes => changes, :event_type => 'update_profile')
    end
  end

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

  def to_param
    self.permalink
  end

  def full_name
    "#{self.first_name} #{self.last_name}".strip
  end

  def store_resume(file, filename)
    self.create_attachment({:file => file , :name => filename})
    self.resume = filename
  end

  def resume_data
    self.read_attachment(self.resume)
  end
end

