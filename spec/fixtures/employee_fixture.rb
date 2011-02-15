class EmployeeWithDefaultValues < BaseFixture
  
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
  property :industry_tags do |industry_tag|
                            industry_tag.property :name, String
                          end

  property :skill_tags do |skill_tag|
                          skill_tag.property :name, String
                          skill_tag.property :rate, Integer
                       end

  property :product_tags do |product_tag|
                            product_tag.property :name, String
                         end


  property :phone_number
  property :email

  property :resume
  property :bio
  property :permalink
  property :professional_info
  property :give_gets
  property :interesting_facts
  property :location

  timestamps!

end