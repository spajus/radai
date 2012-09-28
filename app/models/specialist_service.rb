class SpecialistService < ActiveRecord::Base
  attr_accessible :service_type, :specialist, :service_type_id, :specialist_id, :primary
  belongs_to :service_type
  belongs_to :specialist
end
