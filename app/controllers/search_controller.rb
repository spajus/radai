class SearchController < ApplicationController
  def index
    @results = Specialist.all
    @map_markers = @results.to_gmaps4rails
    @specialist = Specialist.new
  end

  def search
  end
end
