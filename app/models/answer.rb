class Answer < ActiveRecord::Base

  #Associations
  belongs_to :question
  belongs_to :user
  has_many :comments, :as => :commentable

  #Validations
  validates_presence_of [:body]
  validate :only_answer_from_user


  def only_answer_from_user
    if(Answer.find_by_user_id_and_question_id(self.user_id,self.question_id))
      self.errors.add("Answer", 'You alread answered this question! Just edit your answer.')
    end
  end

  def self.is_answered?(question, user)
    if(Answer.find_by_user_id_and_question_id(user.id, question.id))
      true
    else
      false
    end
  end

end
