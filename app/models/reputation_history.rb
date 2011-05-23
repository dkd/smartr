class ReputationHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote
  belongs_to :answer
end

# == Schema Information
#
# Table name: reputation_histories
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  context    :string(255)
#  points     :integer(4)      default(0)
#  reputation :integer(4)      default(0)
#  vote_id    :integer(4)      default(0)
#  answer_id  :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#

