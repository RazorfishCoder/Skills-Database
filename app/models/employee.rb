require 'base_couch_document'

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

  #property :address, :cast_as => 'Address'    #playing around with associations
  property :phone_number
  property :email
  property :resume


  timestamps!

  #############
  # Views
  #############
  view_by :first_name, :last_name
  view_by :updated_at, :descending => true
  view_by :latest_updates
  view_by :id

# Get all employee that have ruby Skills
# Employee.by_skill_tags( :key => 'ruby')
# Get all count of ruby Skills_tag
# Employee.by_skill_tags(:reduce => true, :key => 'ruby')
# Get the count of each Skill tag (Tag Cloud)
# Employee.by_skill_tags(  :reduce => true, :group => true)

  view_by :skill_tags, :map =>
    "function(doc){
      if (doc['couchrest-type'] == 'Employee' && doc['skill_tags']){
        doc.skill_tags.forEach(
          function(skill_tag){
            emit(skill_tag.name, 1);
          }
        );
      }
    };",
    :reduce =>
    "function(keys, values, rereduce){
       return sum(values);
     };"

  view_by :industry_tags, :map =>
    "function(doc){
      if (doc['couchrest-type'] == 'Employee' && doc['industry_tags']){
        doc.industry_tags.forEach(
          function(industry_tag){
            emit(industry_tag.name, 1);
          }
        );
      }
    };",
    :reduce =>
    "function(keys, values, rereduce){
       return sum(values);
     };"

  view_by :product_tags, :map =>
    "function(doc){
      if (doc['couchrest-type'] == 'Employee' && doc['product_tags']){
        doc.product_tags.forEach(
          function(product_tag){
            emit(product_tag.name, 1);
          }
        );
      }
    };",
    :reduce =>
    "function(keys, values, rereduce){
       return sum(values);
     };"

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
  def skill_tags_names(join_str = ', ')
    tags_name_to_s(self.skill_tags,join_str)
  end

  def industry_tags_names(join_str = ', ')
    tags_name_to_s(self.industry_tags,join_str)
  end

  def product_tags_names(join_str = ', ')
    tags_name_to_s(self.product_tags,join_str)
  end

  def store_resume(file, filename)
    self.create_attachment({:file => file , :name => filename})
    self.resume = filename
  end

  def resume_data
    self.read_attachment(self.resume)
  end

  #################
  # private Methods
  #################
  private

  def tags_name_to_s(tags_arr, join_str)
    tags_arr.map{|tag| tag["name"] }.join(join_str) unless tags_arr.blank?
  end
end

