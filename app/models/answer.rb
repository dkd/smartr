class Answer < ActiveRecord::Base
  
  #Associations
  belongs_to [:question, :user]
  has_many :comments, :as => :commentable
  
  #Validations
  validates_presence_of [:body]
    
end
