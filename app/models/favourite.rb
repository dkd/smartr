class Favourite < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :question
  
  #Validations
  validates :user_id, :presence => true
  validates :question_id, :presence => true
  
end
