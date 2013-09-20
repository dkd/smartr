# == Schema Information
#
# Table name: reputation_histories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  context    :string(255)
#  points     :integer          default(0)
#  reputation :integer          default(0)
#  vote_id    :integer          default(0)
#  answer_id  :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

class ReputationHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote
  belongs_to :answer
end
