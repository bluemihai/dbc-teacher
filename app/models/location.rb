class Location < ActiveRecord::Base
  enum status: [:active, :planned, :possible]
end
