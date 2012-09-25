class Specialist < ActiveRecord::Base
  attr_accessible :service_type,
                  :service_type_select,
                  :extra_services,
                  :extra_services_select,
                  :about,
                  :email,
                  :phone,
                  :title,
                  :website

  has_one :service_type

  has_many :extra_services,
           through: :specialist_services,
           class_name: "ServiceType"

  validates :email,
            presence: true,
            uniqueness: true,
            email: true

  validates :phone,
            numericality: true,
            length: {minimum: 11, maximum: 11}

  validates :website,
            url: true

  validates :title,
            presence: true,
            length: {minimum: 6, maximum: 140}

  def service_type_select=(id)
    self.service_type = ServiceType.find(id)
  end

  def service_type_select
    self.service_type.id if self.service_type
  end

  def extra_services_select=(ids)

  end

  def extra_services_select

  end

end
