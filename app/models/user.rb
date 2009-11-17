class User < ActiveRecord::Base
  
  #Plugins
  acts_as_authentic
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "48x48#", :tiny => "16x16#" }
  
  #Associations
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  
  def count_view
    views = self.views.nil?? 0 : self.views
    self.update_attributes :views => (views+1)
  end
  
end
