class FeedbackMailer < ActionMailer::Base
  default from: "info@radai.lt"

  def feedback_email(params)
    @params = params
    mail(from: "info@radai.lt", to: "info@radai.lt", subject: "[Radai Statybos][#{params[:feedback_type]}]")
  end
end
