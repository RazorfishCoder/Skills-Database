class EmployeeEvent < BaseCouchDocument
  property :changes, [String]
  property :event_type

  belongs_to :employee

  timestamps!

  view_by :created_at, :descending => true
end

