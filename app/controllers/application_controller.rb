class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :subdomain_layout

  def subdomain_layout
    if request.subdomain.present?
      request.subdomain
    else
      "index"
    end
  end


end
