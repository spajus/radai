# coding: utf-8
require 'search_params'
class Specialist < ActiveRecord::Base

  scope :desc, order("updated_at DESC")
  scope :primary_service_first, order('`specialist_services`.`primary` DESC')

  acts_as_gmappable
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude
  before_validation :update_geocode


  attr_accessible :user,
                  :user_id,
                  :service_types,
                  :service_type_select,
                  :extra_services_select,
                  :specialist_services,
                  :latitude,
                  :longitude,
                  :about,
                  :email,
                  :phone,
                  :title,
                  :website,
                  :full_address,
                  :show_email,
                  :show_phone

  belongs_to :user

  has_many :specialist_services
  has_many :service_types,
           through: :specialist_services

  validate :contact_privacy, :service_limit

  validates :full_address,
            presence: true

  validates :latitude,
            presence: true

  validates :specialist_services,
            one_primary_service: true

  validates :phone,
            numericality: true,
            length: {minimum: 8, maximum: 11}

  validates :website,
            url: true

  validates :title,
            presence: true,
            length: {minimum: 2, maximum: 140}

  def title_slug
    if title.present?
      title.downcase.strip
        .gsub(/\s+/, '-')
        .gsub(/[Ąą]/, 'a')
        .gsub(/[Čč]/, 'c')
        .gsub(/[ĘĖęė]/, 'e')
        .gsub(/[Įį]/, 'i')
        .gsub(/[Šš]/, 's')
        .gsub(/[ŲŪųū]/, 'u')
        .gsub(/[Žž]/, 'z')
        .gsub(/[^\w-]/, '')
    end
  end

  def og_description
    og_desc = '' << primary_service.title
    if extra_services.length > 0
      og_desc << ', '
      og_desc << extra_services.collect{ |s| s.title }.join(', ')
    end
    og_desc << '.'
  end

  def phone=(phone)
    phone = phone.gsub(/[^0-9]/, '') unless phone.nil?
    super(phone)
  end

  def contact_privacy
    unless (self.show_phone or self.show_email)
      errors.add(:privacy_settings, I18n.translate(
          'app.specialist.privacy_settings_error'))
    end
  end

  def service_limit
    if self.extra_services.length > 5
      errors.add(:extra_services, I18n.translate(
          'app.specialist.extra_services_size_error'))
    end
  end

  def self.search_for(search_params)
    if search_params.example.extra_services.any?
      results = self.page(search_params.page)
        .joins(:specialist_services)
        .group("specialists.id")
        .where("specialist_services.service_type_id in (?)", 
               search_params.service_types).primary_service_first
    end
    unless search_params.example.full_address.blank?
      if results
        results = results.near(search_params.example, search_params.radius).desc
      else
        results = self.page(search_params.page)
            .near(search_params.example, search_params.radius).desc
      end
    end
    if results
      return results
    else
        items = Specialist.desc.page(search_params.page).per(30)
        Kaminari::PaginatableArray.new(
            items.to_a,
            limit: items.limit_value,
            offset: items.offset_value,
            total_count: items.total_count)
      #end
    end
  end

  def primary_service
    primary = self.specialist_services.find_by_primary(true)
    if primary
      return primary.service_type
    else
      raise "No primary service for #{self}"
    end
  end

  def extra_services
    self.specialist_services.reject {|s| s.primary }.collect { |s| s.service_type }
  end

  def has_extra_services?
    self.specialist_services.length > 1 #count goes to db while length checks local array
  end

  def gmaps
    true
  end

  def gmap4rails_address
    self.full_address
  end

  def service_type_select=(id)
    unless id.blank?
      id = id.to_i
      # remove current primary services
      self.specialist_services.each do |s|
        if s.primary or s.service_type_id == id
          self.specialist_services.delete(s)
          break
        end
      end
      self.specialist_services.build(primary: true, service_type_id: id)
    end
  end

  def service_type_select
    self.specialist_services.each do |s|
      if s.primary
        return s.service_type_id
      end
    end
  end

  def extra_services_select=(ids)
    current_ids = []
    primary_id = nil
    self.specialist_services.each do |s|
      if s.primary
        # Remove accidental dupes?
        unless primary_id.nil?
          logger.error "Duplicate primary service! #{self.specialist_services.to_yaml}"
          self.specialist_services.delete(s) unless primary_id.nil?
        end
        primary_id = s.service_type_id.to_s
        next
      end
      unless ids.include?(s.service_type_id.to_s)
        self.specialist_services.delete(s)
      else
        current_ids.append(s.service_type_id.to_s)
      end
    end
    ids.each do |id|
      next if id.to_s == primary_id.to_s
      unless current_ids.include?(id)
        self.specialist_services.build(service_type_id: id)
      end
    end
  end

  def extra_services_include?(id)
    self.specialist_services.collect {|s| s.service_type_id unless s.primary }.include?(id)
  end

  def update_geocode
    unless latitude.present? or latitude_changed?
      should = full_address_changed? 
    end
    if should
      Rails.logger.warn("Geocoding in backend!: #{self}")
      geocode
    end
  end

end
