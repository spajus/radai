# coding: utf-8
class FeedbackController < ApplicationController
  def leave
  end

  def leave_submit
    FeedbackMailer.feedback_email(params).deliver
    flash[:notice] = "Atsiliepimas sėkmingai išsiųstas radai.lt komandai. Ačiū, Jūsų atsiliepimai mums labai svarbūs!"
    render action: "leave"
  end
end
