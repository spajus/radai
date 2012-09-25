class SpecialistController < ApplicationController
  def new
    @specialist = Specialist.new
  end

  def create
    raise params.to_yaml
  end
end
