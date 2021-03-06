# coding: utf-8
class SpecialistController < ApplicationController

  def index
    redirect_to action: "new"
  end

  def show
    @menu_item = "search"
    @specialist = Specialist.find(params[:id])
    if params[:title_slug] != @specialist.title_slug
      redirect_to action: "show", id: @specialist.id, title_slug: @specialist.title_slug
      return
    end
    @map_markers = @specialist.to_gmaps4rails do |obj, marker|
      marker.infowindow render_to_string(
                            partial: "shared/map_marker",
                            locals: {
                                object: obj,
                                search_address: ''
                            })
      marker.title obj.title
    end
  end

  def new
    @specialist = Specialist.new(
        user: User.new,
        show_phone: true,
        show_email: true
    )
  end

  def create
    unless params[:specialist].has_key?("extra_services_select")
      params[:specialist][:extra_services_select] = []
    end
    @specialist = Specialist.new(params[:specialist])
    @specialist.user = User.new(params[:user])

    specialist_valid = @specialist.valid?
    user_valid = @specialist.user.valid?
    if specialist_valid and user_valid
      @specialist.save()
      sign_in @specialist.user
      redirect_to action: "create_complete"
    else
      @specialist.user ||= User.new
      render action: "new"
    end
  end

  def edit
    @specialist = current_user.specialist
  end

  def update
    unless params[:specialist].has_key?("extra_services_select")
      params[:specialist][:extra_services_select] = []
    end
    @specialist = current_user.specialist
    if @specialist.update_attributes params[:specialist]
      flash[:notice] = t('app.save.success')
    end
    render action: "edit"
  end

  def create_complete
    @specialist = current_user.specialist
  end
end
