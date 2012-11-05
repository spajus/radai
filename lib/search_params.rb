class SearchParams < Struct.new(:radius, :location, :service_types, :page, :example)

  def self.build(params)
    search_params = new
    search_params.radius = params[:search_radius] || 50
    search_params.page = params[:page]
    search_params.example = Specialist.new(params[:specialist] || {})
    if params[:specialist]
      search_params.example.geocode
      search_params.service_types = params[:specialist][:extra_services_select]
      search_params.location = params[:specialist][:full_address]
    end
    search_params
  end

end

