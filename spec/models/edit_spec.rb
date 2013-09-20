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

require 'spec_helper'

describe Edit do
  it { should belong_to :editable }
  it { should belong_to :user }
  it { should validate_presence_of :body }
  it { should validate_presence_of :editable }
  it { should ensure_length_of :body }
  
  describe "validation" do
    let(:question) { FactoryGirl.create :question2 }
    
    describe "of body" do
      it "should not have more than 255 chars" do
        edit = FactoryGirl.build(:edit, :editable => question, :body => "a"*256)
        edit.should_not be_valid
      end
      it "should have at least 10 chars" do
        edit = FactoryGirl.build(:edit, :editable => question, :body => "a"*9)
        edit.should_not be_valid
      end
    end
    
    describe "of user" do
      
      it "allows the editable owner to edit" do
        user = question.user
        edit = FactoryGirl.build(:edit, :editable => question, :user => question.user)
        edit.should be_valid
      end
      
      it "does not allow any user to edit" do
        user = FactoryGirl.create(:endless_user)
        edit = FactoryGirl.build(:edit, :editable => question, :user => user)
        edit.should_not be_valid
      end
      
      it "allows an admin to edit" do
        user = FactoryGirl.create(:endless_user, :is_admin => true)
        edit = FactoryGirl.build(:edit, :editable => question, :user => user)
        edit.should be_valid
      end
    end
  end
end
