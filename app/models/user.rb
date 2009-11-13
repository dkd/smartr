class User < ActiveRecord::Base
  acts_as_authentic
  
  #Associations
  has_many :questions
  has_many :answers
  
end
