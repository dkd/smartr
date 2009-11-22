class Answer < ActiveRecord::Base
  
  #Associations
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :votes, :as => :voteable
  
  #Validations
  validates_presence_of [:body]
  validate :only_answer_from_user


  def only_answer_from_user
    if(Answer.find_all_by_user_id_and_question_id(self.user_id,self.question_id).size > 1)
      self.errors.add("Answer", 'You alread answered this question! Just edit your answer.')
    end
  end
  
  def vote(direction, user, model)
    logger.info "#{user.login} voting #{direction} on #{question.name}"
  end
  
end
