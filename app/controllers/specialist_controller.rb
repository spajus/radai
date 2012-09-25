# coding: utf-8
class SpecialistController < ApplicationController

  def index
    redirect_to action: "new"
  end

  def new
    @specialist = Specialist.new
  end

  def create
    @specialist = Specialist.new(params[:specialist])
    if @specialist.save()
      flash[:notice] = "Specialisto anketa užpildyta"
      redirect_to action: "create_complete"
    else
      render action: "new"
    end
  end

  def create_complete

  end


end
