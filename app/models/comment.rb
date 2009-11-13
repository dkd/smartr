class Comment < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  #Validations
  validates_presence_of [:body]
  
end
