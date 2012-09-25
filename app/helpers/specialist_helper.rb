module SpecialistHelper

  def service_types
    ServiceType.all.collect {|t| [t.title, t.id]}.sort
  end

end
