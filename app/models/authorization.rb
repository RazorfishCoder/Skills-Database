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

  ###############
  # Class Methods
  ###############
  def self.find_from_hash(hash)
    by_provider_and_uid :startkey => [hash['provider']], :endkey => [hash['uid']]
  end

  def self.create_from_hash(hash, user = nil)
    user ||= Employee.create_from_hash!(hash)
    Authorization.create(:employee => user, :uid => hash['uid'], :provider => hash['provider'])
  end
end

