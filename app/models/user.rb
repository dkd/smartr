class User < ActiveRecord::Base
  
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "48x48#", :tiny => "16x16#" }
  attr_accessible :email, :login, :password, :password_confirmation, :remember_me, :avatar, :interesting_tag_list, :uninteresting_tag_list
  
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
  scope :online, lambda {
    where "last_request_at > ?", (Time.now - 5.minutes)
  }
  
  #Validations
  validates :email, :presence => true
  validates :login, :presence => true, :length => {:within => 6..12}, :uniqueness => true
  
  #filter
  before_validation :strip_and_downcase_login
  
  def is_online?
    if self.last_request_at > (Time.now - 5.minutes)
      true
    else
      false
    end
  end
  
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
  
  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value }]).first
  end
  
  private
  
  def strip_and_downcase_login
    if login.present?
      login.strip!
      login.downcase!
    end
  end
  
  searchable do
    text :login
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  created_at           :datetime
#  updated_at           :datetime
#  login                :string(255)
#  encrypted_password   :string(255)
#  password_salt        :string(255)
#  sign_in_count        :integer(4)      default(0), not null
#  last_request_at      :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_at   :datetime
#  last_sign_in_ip      :string(255)
#  current_sign_in_ip   :string(255)
#  views                :integer(4)      default(0)
#  email                :string(255)
#  reputation           :integer(4)      default(0)
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer(4)
#  avatar_updated_at    :datetime
#  is_admin             :boolean(1)      default(FALSE)
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  failed_attempts      :integer(4)
#  unlock_token         :string(255)
#  locked_at            :datetime
#

