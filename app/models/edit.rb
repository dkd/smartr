class Edit < ActiveRecord::Base
  belongs_to :user
  belongs_to :editable, :polymorphic => true
  
  validates :body, :presence => true, :length => {:minimum => 10, :maximum => 255}
end
