class Tag < BaseCouchDocument
  property :name
  property :rating

  view_by :name
  view_by :rating
end

