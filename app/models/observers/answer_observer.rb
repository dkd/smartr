class AnswerObserver < ActiveRecord::Observer
  
  def after_create(answer)
    UserMailer.deliver_question_update(answer.question, answer) if (answer.user != answer.question.user && answer.question.send_email == true)
  end
  
end
