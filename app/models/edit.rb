# == Schema Information
#
# Table name: edits
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  editable_type :string(255)
#  editable_id   :integer
#  body          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class CheckOwnershipValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.user.present? && record.editable.user.present?
      record_user = record.user
      if record.editable.user != record_user
        record.errors[attribute] << "You don't have the rights to edit." unless record_user.is_admin == true
      end
    end
  end
end

class Edit < ActiveRecord::Base
  belongs_to :user
  belongs_to :editable, :polymorphic => true

  validates :body, :presence => true, :length => {:minimum => 10, :maximum => 255}
  validates :user, :presence => true, :check_ownership => true
  validates :editable, :presence => true
end
