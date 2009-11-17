class Comment < ActiveRecord::Base
  
  SCORE_UP = 5
  SCORE_DOWN = -5
  SCORE_PENALTY = -2
  
  #Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :voteable
  
  #Validations
  validates_presence_of [:body]
  
end
