class Authorization < BaseCouchDocument
  #############
  # Properties
  #############
  belongs_to :employee
  property :provider
  property :uid
  timestamps!

  #############
  # Views
  #############
  view_by :provider, :uid

  #############
  # Validations
  #############
  validates_uniqueness_of :uid

  ###############
  # Class Methods
  ###############
  def self.find_from_hash(hash)
    find_by_provider_and_uid [hash['provider'], hash['uid']]
  end

  def self.create_from_hash(hash, user = nil)
    user ||= Employee.create_from_hash!(hash)

    if user
      create(:employee => user, :uid => hash['uid'], :provider => hash['provider'])
    else
      return false
    end
  end
end

