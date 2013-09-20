# == Schema Information
#
# Table name: favourites
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Favourite < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :question

  # Validations
  validates :user, :presence => true
  validates :user, :presence => true

  # Kaminari Pagination
  #paginates_per 15

end
