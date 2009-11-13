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
  
  
  #methods
  
  def self.recent_tags
    list = []
    self.latest(:limit => 10).each do |question|
      question.tag_list.each do |tag|
        list << tag unless list.include?(tag)
      end
    end    
    list
  end
  
  
end