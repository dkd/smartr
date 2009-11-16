class User < ActiveRecord::Base
  
  #Plugins
  acts_as_authentic
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "48x48#", :tiny => "16x16#" }
  
  #Associations
  has_many :questions
  has_many :answers
  
end
