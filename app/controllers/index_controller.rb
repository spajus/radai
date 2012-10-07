class IndexController < ApplicationController
  layout "index"

  def list
  end

  def missing
    path = params[:path]
    flash[:error] = t('app.route.missing')
    redirect_to action: 'list'
  end
end
