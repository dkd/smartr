require "rubygems"
require 'ruby-growl' if RAILS_ENV == "development"

class Tell
  attr_accessor :g
  def initialize(message)
   g = Growl.new("localhost", "ruby-growl", ["ruby-growl Notification"], ["ruby-growl Notification"], nil) if RAILS_ENV == "development"
   g.notify("ruby-growl Notification", "Reputation", message, 1, true) if RAILS_ENV == "development"
  end
end

class Answer < ActiveRecord::Base
  
  #Associations
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
  
  #Validations
  validate :only_answer_from_user
  validates_length_of :body, :minimum => 75
  
 #Sunspot Solr
 
 searchable do
   text :body_plain
   integer :question_id
   integer :user_id
   time :created_at
   time :updated_at
 end  

  def only_answer_from_user
    if(Answer.find_all_by_user_id_and_question_id(self.user_id,self.question_id).size > 1)
      self.errors.add("Answer", 'You alread answered this question! Just edit your answer.')
    end
  end
  
  def vote(direction, user, model)
    logger.info "#{user.login} voting #{direction} on #{question.name}"
  end
  
  def toggle_acception
          
  end
end
