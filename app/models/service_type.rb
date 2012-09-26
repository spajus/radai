class ServiceType < ActiveRecord::Base
  attr_accessible :approved,
                  :slug,
                  :title,
                  :specialists,
                  :specialist_services

  order :title

  has_many :master_specialists, class_name: "Specialist", foreign_key: :service_type_id
  has_many :specialist_services
  has_many :specialists, through: :specialist_services
end
