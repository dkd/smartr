# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  accepted    :boolean
#  body_plain  :text
#  send_email  :boolean          default(FALSE)
#  votes_count :integer          default(0)
#

require 'spec_helper'

describe Answer do

  describe "relations" do
    it { should have_many :votes }
    it { should belong_to :question }
    it { should belong_to :user }
  end

  describe "Validations of" do

    describe "of body" do
      it "requires presence" do
        answer = FactoryGirl.build(:answer, :body => nil)
        answer.should_not be_valid
      end

      it "requires a minimum length of 75 characters" do
        answer = FactoryGirl.build(:answer, :body => "This answer is too short!")
        answer.should_not be_valid
      end

      it "cannot be longer than 2048 characters" do
        answer = FactoryGirl.build(:answer, :body => "a"*2049)
        answer.should_not be_valid
      end

    end

    describe "model methods" do
      let(:answer) { FactoryGirl.create(:full_answer) }
      it "should not be the accepted answer" do
        answer.accepted?.should be_false
      end
      it "should be the accepted answer" do
        answer.question.accepted_answer = answer
        answer.accepted?.should be_true
      end
    end

    describe "restrict number of answers for question" do
      it "permit only one one answer from the same user" do
        user = FactoryGirl.create(:user2) 
        question = FactoryGirl.create(:question, :user_id => user.id)
        answer = FactoryGirl.create(:answer, :question => question, :user => question.user)
        another_answer_from_same_user = FactoryGirl.create(:answer, :question => question, :user => question.user)
        another_answer_from_same_user.should_not be_valid
      end
    end

    describe "saving record" do
      it "should create the record" do
        user = FactoryGirl.create(:user2) 
        question = FactoryGirl.create(:question, :user_id => user.id)
        answer = FactoryGirl.create(:answer, :question => question, :user => question.user)
        question.reload.answers_count.should eq(1)
        answer.should be_valid
      end
    end

  end
end
