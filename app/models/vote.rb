class Vote < ActiveRecord::Base
  
  #Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  
  #filter
  #after_save :count_on
  
  
  def cast(direction)
    
    user = self.voteable_type.constantize.find(self.voteable_id).user
    
    case direction
      when "up"
        value = self.value + 1
        Reputation.set("up", self.voteable_type, self.user, user) if self.value == -1 || self.value == 0
      when "down"
        value = self.value - 1
        Reputation.set("down", self.voteable_type, self.user, user) if self.value == 1 || self.value == 0
        Reputation.penalize(self.voteable_type, self.user, user) if value == -1
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
