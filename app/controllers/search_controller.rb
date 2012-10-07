class SearchController < ApplicationController

  def index
    if params[:specialist]
      @specialist = Specialist.new(params[:specialist])
      @specialist.geocode
      @search_radius = params[:search_radius]
    else
      @specialist = Specialist.new
      @search_radius = 100
    end
    @results = Specialist.search_for(params, @search_radius, request)
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

  def search
  end
end
