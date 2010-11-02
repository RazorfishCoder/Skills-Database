require 'BaseExtendedDocument'

class Contact < BaseExtendedDocument
    
  property :first_name
  property :last_name, :alias => :family_name  #playing around with aliases
  property :company_name
  property :job_title
  property :tags, [String]
  property :address, :cast_as => 'Address'
  property :phone_number
  property :email
  timestamps!
  
  view_by :first_name
  
end