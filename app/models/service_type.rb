class ServiceType < ActiveRecord::Base
  attr_accessible :approved,
                  :slug,
                  :title,
                  :specialists,
                  :specialist_services

  order :title

  has_many :specialist_services
  has_many :specialists, through: :specialist_services

  def self.find_provided
    SpecialistService.joins(:service_type)
      .order("service_types.title")
      .all(select: "distinct service_types.id, service_types.title")
      .collect { |s| { id: s.id, title: s.title } }
  end
end
