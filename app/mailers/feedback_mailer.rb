class FeedbackMailer < ActionMailer::Base
  default from: "feedback-statybos@radai.lt"

  def feedback_email(params)
    @params = params
    mail(from: "info@radai.lt", to: "info@radai.lt", subject: "[statybos.radai.lt][#{params[:feedback_type]}]")
  end
end
