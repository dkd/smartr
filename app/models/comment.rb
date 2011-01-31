class Comment < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :voteable
  
  #Validations
  validates :body, :presence => true, :length => {:minimum => 25, :maximum => 280}
  searchable do
    text :body
  end
end
# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  user_id          :integer(4)
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

