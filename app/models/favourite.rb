class Favourite < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :question

  # Validations
  validates :user, :presence => true
  validates :user, :presence => true

  # Kaminari Pagination
  paginates_per 15

end

# == Schema Information
#
# Table name: favourites
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  question_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

