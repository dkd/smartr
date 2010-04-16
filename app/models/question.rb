class Question < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :favourites, :dependent => :destroy
  belongs_to :answer
    
  #Validations
  validates_presence_of [:body, :name, :tag_list]
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 20
  validates_length_of :body, :minimum => 75
  
  #Extensions
  acts_as_taggable_on :tags
  has_friendly_id :permalink
  
  #Named Scopes
  default_scope :include => :user
  named_scope :latest, :order => "created_at DESC"
  named_scope :hot, :order => "answers_count DESC,updated_at DESC"
  named_scope :active, :order => "updated_at DESC, answers_count DESC"
  named_scope :unanswered, :order => "created_at ASC", :conditions => ["answers_count = ?", "0"]
  
  # Callbacks
  before_save :set_permalink
  before_save :check_answer_count
  
  #Sunspot Solr
  searchable do
    text :name, :boost => 2.0
    text :body_plain
    integer :user_id, :references => User
    
    text :answers do 
      answers.map {|answer| 
        answer.body_plain
      }
    end
    
    text :comments do
      comments.map {|comment|
        comment.body
      }
    end
    
    text :user do
      user.login
    end
    
    text(:tags) do 
      tags.map{|tag| tag.name}
    end
    
    time :updated_at
    time :created_at
    
    integer :id
    
    string :sort_title do
      name.downcase.sub(/^(an?|the) /, '')
    end
  end
  
  #Methods
  def self.recent_tags
    list = []
    self.latest(:limit => 5).each do |question|
      question.tag_list.each do |tag|
        list << tag unless list.include?(tag)
      end
    end
    list
  end
  
  def favourited?(user)
    Favourite.find_by_user_id_and_question_id(user.id, self).present?
  end
  
  # Callback methods
  def set_permalink
    self.permalink = self.name.to_permalink
  end
  
  def check_answer_count
    self.answers_count = 0 if self.answers_count.nil?
  end
  
  def update_views
    number_of_views = self.views.nil?? 0 : self.views
    self.views = number_of_views + 1
    self.save(false)
  end
  
  def answered?(user)
    if(Answer.find_by_user_id_and_question_id(user.id, self.id))
      true
    else
      false
    end
  end
  
end
