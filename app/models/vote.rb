class Vote < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  
  #filter
  #after_save :count_on
  
  #scopes
  default_scope :order => "updated_at asc"
  
  #Virtual Attribute
  attr_accessor :direction
  
  #validations
  validates :direction, :presence => true, :format => /u|down/
  
  def self.has_voted?(user, record)
    v = Vote.find_by_user_id_and_voteable_type_and_voteable_id(user.id, record.class.name, record.id)
    if(v)
      v.value
    else
      false
    end
  end
  
  def already_voted?(direction)
    
  end
  
  def cast(direction)
    
    target_user = self.voteable_type.constantize.find(self.voteable_id).user
    orginal_value = self.value
    
    case direction
      when "up"
        value = self.value + 1
        Reputation.unpenalize(self.voteable_type, self.user, target_user) if self.value == -1
        Reputation.set("up", self.voteable_type, self.user, target_user) if self.value == -1 || self.value == 0
      when "down"
        value = self.value - 1
        Reputation.set("down", self.voteable_type, self.user, target_user) if self.value == 1 || self.value == 0
        Reputation.penalize(self.voteable_type, self.user, target_user) if value == -1
    end
    
    if(value == 1 || value == -1)
      self.update_attributes :value => value      
    elsif(value == 0)
      self.destroy
    end
    
    Vote.count_on(self.voteable_type, self.voteable_id)
    
  end
  
  def self.count_on(type, id)
    rating = 0
    record = type.constantize.find(id)    
    
    record.votes.each do |vote|
     rating = rating + vote.value
    end
     rating
  end

end
