class User < ActiveRecord::Base
  
  #Plugins
  #acts_as_authentic
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatablem,
         :token_authenticatable, :confirmable, :lockable, :timeoutable
  
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "48x48#", :tiny => "16x16#" }
  attr_accessible :email, :login, :password, :password_confirmation, :remember_me
  #Associations
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :favourites
  
  attr_accessor :image_url
  
  #Plugins
  acts_as_taggable_on :interesting_tags
  acts_as_taggable_on :uninteresting_tags
  has_friendly_id :login
  
  #Named Scopes
  scope :latest, :order => "created_at DESC"
  
  # Validations
  validates :email, :presence => true
  validates :login, :presence => true, :length => {:within => 6..12}
  
  def count_view
    views = self.views.nil?? 0 : self.views
    self.update_attributes :views => (views+1)
  end
  
  def latest_questions
    Question.find_all_by_user_id(self.id, :limit => 5, :order => 'created_at desc')
  end
  
  def latest_answers
    Question.find(:all, :limit => 5, :order => "answers.created_at desc", :joins => :answers, :conditions => ['answers.user_id=?', self.id])
  end
  
  def image_url
    self.image_url = self.avatar.url(:medium)
  end
  
end

#Sunspot Solr Configuration
Sunspot.setup(User) do
  text :login
end
