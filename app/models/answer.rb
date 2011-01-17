class Answer < ActiveRecord::Base
  
  #Associations
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
  
  #Validations
  validate :only_answer_from_user
  validates :body, :presence => true, :length => {:minimum => 75, :maximum => 2048}

  def only_answer_from_user
    if(Answer.find_all_by_user_id_and_question_id(self.user_id,self.question_id).size > 1)
      self.errors.add("Answer", 'You alread answered this question! Just edit your answer.')
    end
  end

end

#Sunspot Solr Configuration
Sunspot.setup(Answer) do
  text :body_plain
  integer :question_id
  integer :user_id
  time :created_at
  time :updated_at
end
