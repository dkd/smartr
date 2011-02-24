class Question < ActiveRecord::Base
  
  #Associations
  belongs_to  :user
  has_many    :comments, :as => :commentable, :dependent => :destroy
  has_many    :votes, :as => :voteable, :dependent => :destroy
  has_many    :answers, :dependent => :destroy
  has_many    :favourites, :dependent => :destroy
  belongs_to  :accepted_answer, :class_name => "Answer", :foreign_key => :answer_id
  has_many :edits, :as => :editable, :dependent => :destroy
  
  #Validations
  validates_presence_of [:body, :name]
  validates_uniqueness_of [:name, :body]
  validates_length_of :name, :minimum => 20
  validates_length_of :body, :minimum => 75
  validates :tag_list, :presence => true, :length => {:maximum => 8}
  
  
  # Nested Forms
  accepts_nested_attributes_for :edits
  
  #Extensions
  acts_as_taggable_on :tags
  acts_as_tagger
  has_friendly_id :permalink
  
  #Named Scopes
  scope :list, :joins => [:taggings, :user], :group => "questions.id", :include => [:user, :votes, :taggings]
  scope :latest, :order => "questions.created_at DESC"
  scope :hot, :order => "answers_count DESC, questions.updated_at DESC"
  scope :active, :order => "questions.updated_at DESC, answers_count DESC"
  scope :unanswered, :order => "questions.created_at ASC", :conditions => ["answers_count = ?", "0"]
  
  # Callbacks
  before_validation :set_permalink
  before_validation :clean_up_tags
  before_save :check_answer_count
  
  #Methods
  def favourited?(user)
    Favourite.find_by_user_id_and_question_id(user.id, self).present?
  end

  def set_permalink
    self.permalink = self.name.to_url unless self.name.nil?
  end
  
  def check_answer_count
    self.answers_count = 0 if self.answers_count.nil?
  end
  
  def update_views
    number_of_views = self.views.nil?? 0 : self.views
    self.views = number_of_views + 1
    self.save(:validate => false)
  end
  
  def answered_by?(user)
    if(Answer.find_by_user_id_and_question_id(user.id, self.id))
      true
    else
      false
    end
  end
  
  def clean_up_tags
    @tag_list.map! {|tag| tag.scan(/[\d\w\d{0,2}]+/).first}.map!(&:downcase) unless @tag_list.nil?
  end
   
  #Sunspot Configuration
  searchable do
    text :name, :boost => 5.0
    text :body
    integer :user_id, :references => User

    text :answers do 
      answers.map {|answer| 
        answer.body_plain
      }
    end
    
    boolean :question_state do
      accepted_answer.nil? ? false : true
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


end

