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
  named_scope :latest, :order => "created_at DESC"
  named_scope :hot, :order => "updated_at DESC, answers_count DESC"
  named_scope :active, :order => "updated_at DESC, answers_count DESC"
  named_scope :unanswered, :order => "created_at ASC", :conditions => ["answers_count = ?", "0"]
  
  #scope_procedure :taggable_with_tags, lambda { |tags|
  #    tagged_with(tags, :on => :tags) 
  #}
  
  #Sunspot Solr
  searchable do
    text :name, :boost => 2.0
    text :body_plain
    integer :user_id, :references => User
    text :answers do 
      answers.map {|answer| answer.body_plain}
    end
    text :user do
      user.login
    end
    
    string(:tags, :multiple => true) do 
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
    self.latest(:limit => 10).each do |question|
      question.tag_list.each do |tag|
        list << tag unless list.include?(tag)
      end
    end    
    list
  end
  
  def self.solr
    searchstring = "ruby"
    page = 1 
    q = Sunspot.search(Question) do 
      fulltext searchstring do
        highlight :name, :body_plain, :max_snippets => 3, :fragment_size => 200
        tie 0.1
      end
      facet :user_id
      facet :tags
      paginate(:page =>  page, :per_page => 10)
    end
    
  end
  
  
  def before_save
    self.answers_count = 0 if self.answers_count.nil?
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
