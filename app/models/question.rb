class Question < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :answers
  
  #Validations
  validates_presence_of [:body, :name]
  validates_uniqueness_of :name 
end