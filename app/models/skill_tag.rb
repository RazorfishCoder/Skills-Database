#require 'base_couch_document'

class SkillTag < Tag

  validates_uniqueness_of :name
  #property :name inherit from Tag
  #property :context inherit from Tag

#  def initialize
#    self.context = 'Skill'
#  end



#    def self.bulk_create(names_str ,cut_str = ", ", employee)
#        #this create make a Find or Create behavior
#       employee.skill_tags = names_sts.split(cut_str).map{  |x|  SkillTag.create(:name => x)}
#    end

end

