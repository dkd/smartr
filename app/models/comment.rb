class Comment < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :voteable
  
  #Validations
  validates :body, :presence => true, :length => {:minimum => 25, :maximum => 280}
  
end