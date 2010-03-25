class User < ActiveRecord::Base
  
  #Plugins
  acts_as_authentic
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "48x48#", :tiny => "16x16#" }
  
  #Associations
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :favourites
  
  #Plugins
  acts_as_taggable_on :interesting_tags
  acts_as_taggable_on :uninteresting_tags
  has_friendly_id :login
  
  #Search
  
  searchable do
    text :login
  end
  
  def count_view
    views = self.views.nil?? 0 : self.views
    self.update_attributes :views => (views+1)
  end
  
  
  
end
