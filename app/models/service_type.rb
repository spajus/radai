class ServiceType < ActiveRecord::Base
  attr_accessible :approved,
                  :slug,
                  :title,
                  :specialists,
                  :specialist_services

  order :title

  has_many :specialist_services
  has_many :specialists, through: :specialist_services
end
