#require 'base_couch_document'

class ProductTag < Tag
  validates_uniqueness_of :name

  #property :name inherit from Tag
  #property :context inherit from Tag


#  def initialize
#    self.context = 'Product'
#  end

end

