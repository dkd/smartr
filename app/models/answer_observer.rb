class AnswerObserver < ActiveRecord::Observer

  def after_create(answer)
    UserMailer.question_update(answer.question, answer).deliver if (answer.user != answer.question.user && answer.question.send_email == true)
  end

end
