#require 'base_couch_document'

class IndustryTag < Tag
  validates_uniqueness_of :name
  #property :name inherit from Tag
  #property :context inherit from Tag

#  def initialize
#    self.context = 'Industry'
#  end

end

