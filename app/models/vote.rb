# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  voteable_type :string(255)
#  voteable_id   :integer
#  user_id       :integer
#  value         :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

# Checks if user has already voted on model
class CheckVoteValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    votes = Vote.where("user_id =? and voteable_type=? and voteable_id=?", record.user_id, record.voteable_type, record.voteable_id)
    record.errors[attribute] << "This user already voted" if votes.count > 0 && record.id.nil?
  end
end
# Checks if user tries to vote on an object he owns
class CheckVoteOwnerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "You cannot vote on yourself" if record.voteable.present? && record.user == record.voteable.user
  end
end

class CheckDirectionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.to_s.match(/(^up$)|(^down$)/).nil?
      record.errors[attribute] << "Direction is invalid"
    end
    record.errors[attribute] << "Nothing changed" if record.value_was == record.value

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

class Vote < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true

  # Callbacks
  after_save :update_reputation

  # Scopes
  default_scope :order => "updated_at asc"

  # Virtual Attributes
  attr_reader :direction

  # Protect Attributes
  attr_accessible :value

  # Validations
  validates :user, :presence => true, :check_vote => true
  validates :voteable, :presence => true

  validates :value, :presence => true, :check_direction => true, :check_vote_owner => true
  validates :direction, :presence => true, :format => {:with =>  /up|down/}

  def receiver
    voteable.user
  end

  def owner
    user
  end

  def type_pluralize
    voteable_type.downcase.pluralize
  end

  def type_to_sym
    voteable_type.downcase.to_sym
  end

  def voteables_count
    voteable.votes_count
  end

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

  private

  def update_reputation
    target_user = self.voteable.user

    if direction == "up"
      new_value = value_was + 1
      Reputation.set("up", self.voteable_type, self.user, target_user) if value_was == -1 || value_was == 0
      Reputation.unpenalize(self.voteable_type, self.user, target_user) if value_was == -1
    elsif direction == "down"
      new_value = value_was - 1
      Reputation.set("down", self.voteable_type, self.user, target_user) if value_was == 1 || value_was == 0
      Reputation.penalize(self.voteable_type, self.user, target_user) if value_was == 0
    end

    if new_value == 0
      self.destroy
    end
    update_votes_count
  end

  def update_votes_count
    rating = 0
    self.voteable.reload
    self.voteable.votes.each { |vote| rating += vote.value }
    self.voteable.votes_count = rating
    self.voteable.save(:validate => false)
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
