class Specialist < ActiveRecord::Base
  attr_accessible :about, :email, :phone, :title, :website
  has_one :service_type
  has_many :service_types, through: :specialist_services

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

end
