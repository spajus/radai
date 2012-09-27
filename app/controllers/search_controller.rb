class SearchController < ApplicationController

  def index
    if params[:specialist]
      @specialist = Specialist.new(params[:specialist])
      @specialist.geocode
    else
      @specialist = Specialist.new
    end
    if @specialist.full_address.blank?
      @results = Specialist.all
    else
      @results = Specialist.search_for(params)
    end
    @map_markers = @results.to_gmaps4rails do |obj, marker|
      marker.infowindow render_to_string(partial: "shared/map_marker", locals: {object: obj})
      marker.title obj.title
    end
    @map_markers
  end

  def search
  end
end
