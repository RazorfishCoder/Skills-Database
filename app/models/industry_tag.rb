=begin
No needed defined in Employee Document
#require 'base_couch_document'

class IndustryTag < Tag
  belongs_to :employee

  validates_uniqueness_of :name

  view_by :name

  #property :name inherit from Tag
  #property :context inherit from Tag

#  def initialize
#    self.context = 'Industry'
#  end

end
=end

