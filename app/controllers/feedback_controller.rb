# coding: utf-8
class FeedbackController < ApplicationController
  def leave
  end

  def leave_submit
    FeedbackMailer.feedback_email(params).deliver
    flash[:notice] = t('app.feedback.sent')
    render action: "leave"
  end
end
