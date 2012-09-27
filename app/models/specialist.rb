class Specialist < ActiveRecord::Base

  acts_as_gmappable
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :full_address_changed?  # auto-fetch address

  attr_accessible :user,
                  :user_id,
                  :service_type,
                  :service_type_id,
                  :service_type_select,
                  :extra_services,
                  :extra_services_select,
                  :specialist_services,
                  :latitude,
                  :longitude,
                  :about,
                  :email,
                  :phone,
                  :title,
                  :website,
                  :full_address

  belongs_to :user

  belongs_to :service_type

  has_many :specialist_services
  has_many :extra_services,
           through: :specialist_services,
           class_name: "ServiceType",
           source: :service_type

  validates :full_address,
            presence: true

  validates :service_type,
            presence: true

  validates :phone,
            numericality: true,
            length: {minimum: 11, maximum: 11}

  validates :website,
            url: true

  validates :title,
            presence: true,
            length: {minimum: 2, maximum: 140}

  def gmaps
    true
  end

  def gmap4rails_address
    self.full_address
  end

  def service_type_select=(id)
    unless id.blank?
      self.service_type = ServiceType.find(id)
    end
  end

  def service_type_select
    self.service_type.id if self.service_type
  end

  def extra_services_select=(ids)
    current_ids = []
    self.extra_services.each do |s|
      unless ids.include?(s.id)
        raise "TODO deleting extra service #{s}"
      else
        current_ids.append(s.id)
      end
    end
    ids.each do |id|
      next if id.to_i == self.service_type.id
      unless current_ids.include?(id)
        self.extra_services.append(ServiceType.find(id))
      end
    end
  end

  def extra_services_select
    self.extra_services.collect {|s| [s.title, s.id]}
  end

end
