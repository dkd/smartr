class CheckVoteValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if record.value_was == 1
      if record.value_changed?
        record.errors[attribute] << "Already Voted in that direction" unless (record.value == -1)
      end
    end
    
    if record.value_was == -1
      if record.value_changed?
        record.errors[attribute] << "Already Voted in that direction" unless (record.value == 1)
      end
    end
  end
end

class CheckDirectionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.to_s.match(/(^up$)|(^down$)/).nil?
      record.errors[attribute] << "Direction is invalid"
    end
    record.errors[attribute] << "Nothing changed" if record.value_was == record.value
  end
end

class Vote < ActiveRecord::Base
  
  # Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  
  # Callbacks
  before_save :check_for_vote
  after_save :update_reputation
  
  # Scopes
  default_scope :order => "updated_at asc"
  
  # Virtual Attributs
  attr_reader :direction
  
  # Validations
  validates :user, :presence => true
  validates :voteable, :presence => true
  validates :value, :presence => true, :check_direction => true, :check_vote => true
  validates :direction, :presence => true, :format => {:with =>  /up|down/}
  
  def direction
    case value
      when 1
        "up"
      when -1
        "down"
      else
        nil
    end
  end
  
  
  def check_for_vote
    vote = Vote.find_by_user_id_and_voteable_type_and_voteable_id(self.user.id, self.voteable.class.name, self.voteable.id)
  end
  
  def self.has_voted?(user, record)
    vote = Vote.find_by_user_id_and_voteable_type_and_voteable_id(user.id, record.class.name, record.id)
    if(vote)
      vote.value
    else
      false
    end
  end

  
  def update_votes_count
    rating = 0
    Rails.logger.info "Rating is 0"
    voteable.votes.each {|vote|
      rating += vote.value
      Rails.logger.info "Rating is #{rating}"
      }
    voteable.update_attributes(:votes_count => rating)
  end
  
  def update_reputation
    
    target_user = self.voteable.user
    Rails.logger.info "Original Value #{value_was}"
    Rails.logger.info "Current Value #{value}"
    
    case direction
      when "up"
        Rails.logger.info "Trying to vote up"
        new_value = value_was + 1
        Reputation.set("up", self.voteable_type, self.user, target_user) if value_was == -1 || value_was == 0
        Reputation.unpenalize(self.voteable_type, self.user, target_user) if value_was == -1
      when "down"
        Rails.logger.info "Trying to vote down"
        new_value = value_was - 1
        Reputation.set("down", self.voteable_type, self.user, target_user) if value_was == 1 || value_was == 0
        Reputation.penalize(self.voteable_type, self.user, target_user) if value_was == 1 || value_was == 0
    end
    Rails.logger.info "was :#{value_was} / is:#{value} / calc: #{new_value}"
    Rails.logger.info "votable.votes_count: #{voteable.votes_count}"
    if new_value == 0
      Rails.logger.info "VOTEABLE COUNT SHOULD BE #{(voteable.votes_count + value)}"
      self.delete
    end
    rating = 0
    voteable.reload
    voteable.votes.each {|vote|
      rating += vote.value
      Rails.logger.info "Rating is #{rating}"
      }
    voteable.update_attributes(:votes_count => rating)
    voteable.votes.reload
  end
  
end

# == Schema Information
#
# Table name: votes
#
#  id            :integer(4)      not null, primary key
#  voteable_type :string(255)
#  voteable_id   :integer(4)
#  user_id       :integer(4)
#  value         :integer(4)      default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

