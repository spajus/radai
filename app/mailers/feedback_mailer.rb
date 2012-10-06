class FeedbackMailer < ActionMailer::Base
  default from: "info@radai.lt"

  def feedback_email(params)
    @params = params
    mail(from: "info@radai.lt", to: "tomas.varaneckas+radai@gmail.com", subject: "[Radai][#{params[:feedback_type]}]")
  end
end
