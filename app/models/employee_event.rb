class EmployeeEvent < BaseCouchDocument
  property :changes, [String]
  property :event_type

  belongs_to :employee

  timestamps!
end

