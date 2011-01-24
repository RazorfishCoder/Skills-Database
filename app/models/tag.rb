=begin
No needed defined in Employee Document
require 'base_couch_document'

class Tag < BaseCouchDocument
  validates_uniqueness_of :name

  property :name
  property :type

  view_by :name

    def self.bulk_create(names_str, cut_str = ", ")
        #this create make a Find or Create behavior
        names_str.split(cut_str).map{  |x|  self.create(:name => x)}
    end

end
=end

