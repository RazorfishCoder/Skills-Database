class Search < BaseCouchDocument
  property :search

  belongs_to :employee

  timestamps!

  view_by :created_at, :descending => true
end
