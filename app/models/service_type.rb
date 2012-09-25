class ServiceType < ActiveRecord::Base
  attr_accessible :approved, :slug, :title, :specialists
  order :title => "asc"

  has_many :specialists, through: :specialist_services
end
