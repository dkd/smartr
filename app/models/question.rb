class Question < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :votes, :as => :voteable
  has_many :answers
  
  #Validations
  validates_presence_of [:body, :name, :tag_list]
  validates_uniqueness_of :name
  
  #Extensions
  acts_as_taggable_on :tags
  
  #Named Scopes
  default_scope :include => :user
  named_scope :latest, :order => "created_at DESC", :include => [:user]
  
  #Nested Attributes
  accepts_nested_attributes_for :answers, :allow_destroy => true
  
  #Accessor
  
  #Methods
  def self.recent_tags
    list = []
    self.latest(:limit => 10).each do |question|
      question.tag_list.each do |tag|
        list << tag unless list.include?(tag)
      end
    end    
    list
  end
 
  def update_views
    number_of_views = self.views.nil?? 0 : self.views
    self.views = number_of_views + 1
    self.save!
  end
  
  def answered?(user)
    if(Answer.find_by_user_id_and_question_id(user.id, self.id))
      true
    else
      false
    end
  end
  
end
