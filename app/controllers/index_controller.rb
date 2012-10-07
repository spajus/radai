class IndexController < ApplicationController
  respond_to :html, :png
  layout "index"

  def list
    respond_to do |format|
      format.html
      format.png { redirect_to view_context.image_path('index/radai.png') }
    end
  end

  def missing
    path = params[:path]
    Rails.logger.error("Missing path: [#{path}]. [UA: #{request.env["HTTP_USER_AGENT"]}][IP: #{request.remote_ip}]")
    flash[:error] = t('app.route.missing')
    redirect_to action: 'list'
  end
end
