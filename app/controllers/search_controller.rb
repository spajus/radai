class SearchController < ApplicationController

  def index
    search_params = SearchParams.build params
    @specialist = search_params.example
    @search_radius = search_params.radius
    @results = Specialist.search_for(search_params)
    @map_markers = @results.to_gmaps4rails do |obj, marker|
      marker.infowindow render_to_string(
                            partial: "shared/map_marker",
                            locals: {
                                object: obj,
                                search_address: @specialist.full_address,
                                search_location: [@specialist.latitude, @specialist.longitude]
                            })
      marker.title obj.title
    end
  end
end
