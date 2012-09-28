# coding: utf-8
class SpecialistController < ApplicationController

  def menu_item
    "specialist"
  end

  def index
    redirect_to action: "new"
  end

  def show(id)
    @specialist = Specialist.find(id)
    render action: "new"
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
      flash[:notice] = "Pakeitimai sėkmingai išsaugoti."
    end
    render action: "edit"
  end

  def create_complete
    @specialist = current_user.specialist
  end

  def ajax_address_search
    address = params[:address]
    if address.empty?
      render nothing: true
    else
      result = Geocoder::search(address)
      if result.nil?
        render nothing: true
      else
        render json: result.first.data
      end
    end

  end

end
