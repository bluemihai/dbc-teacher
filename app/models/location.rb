class Location < ActiveRecord::Base
  enum status: [:active, :planned, :possible]
  has_many :users
end
