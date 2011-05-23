class QuestionObserver < ActiveRecord::Observer

  def after_update(question)
    ActionController::Base.new.expire_fragment "question_view_#{question.id}"
  end

  def after_destroy(question)
     ActionController::Base.new.expire_fragment "question_view_#{question.id}"
  end

end
