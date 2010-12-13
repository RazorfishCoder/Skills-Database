require 'BaseCouchDocument'

class Address < BaseCouchDocument
  
  property :line_1
  property :line_2
  property :city
  property :state
  property :zip_code
  property :country, :default => "USA"

  def to_s
    address_str = "#{line_1}"
    address_str << ",\n #{line_2}" if line_2
    address_str << "\n"
    address_str << "#{city}, " if city
    address_str << "#{state}" if state
    address_str << " #{zip_code}" if zip_code
    address_str << "\n#{country}" if country
    address_str
  end
end
