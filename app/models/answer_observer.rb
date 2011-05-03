class AnswerObserver < ActiveRecord::Observer

  def after_create(answer)
    question = answer.question
    if (answer.user != question.user && question.send_email == true)
      UserMailer.question_update(question, answer).deliver
    end
  end

end
