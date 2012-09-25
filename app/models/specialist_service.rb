class SpecialistService < ActiveRecord::Base
  belongs_to :service_type
  belongs_to :specialist
end
