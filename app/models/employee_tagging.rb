class EmployeeTagging < BaseCouchDocument

  belongs_to  :skill_tag
  belongs_to  :employee

#  validates_uniqueness_of :skill

  property :rating

#  view_by :skill_tag
#  view_by :employee

end

