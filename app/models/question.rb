class Question < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :answers
  
  #Validations
  validates_presence_of [:body, :name]
  validates_uniqueness_of :name
  
  #Extensions
  acts_as_taggable_on :tags
  
  #Named Scopes
  named_scope :latest, :order => "created_at DESC"
  
  
end