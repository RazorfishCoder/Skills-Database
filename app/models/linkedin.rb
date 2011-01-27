class Linkedin < BaseCouchDocument

  #############
  # Properties
  #############
  property :api_key
  property :secret_key

  #############
  # Validations
  #############
  validates_uniqueness_of :api_key

end

