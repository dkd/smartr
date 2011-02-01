require 'spec_helper'

describe Reputation do
  
  context "Question acceptance:" do
    describe "the question owner" do
      let(:question) { Factory.create(:question2)}
      describe "accepts his own answer" do
        before do
          question.answers << Factory.build(:answer, :user => question.user)
          question.save
        end
        it "so the question has an accepted answer, but the owner gets no extra points" do
          Reputation.toggle_acceptance(question, question.answers.first)
          question.reload
          question.accepted_answer.should == question.answers.first
          question.user.reputation.should == 0
        end
      end       
 
      describe "revokes acceptance of an answer" do
        before do
          question.answers << Factory.build(:answer, :user => Factory.create(:user2))
          question.save
          Reputation.toggle_acceptance(question, question.answers.last)
        end
        it "so the question has no accepted answer anymore and the answer owner loses reputation" do
          question.accepted_answer.user.reputation.should == Smartr::Settings[:reputation][:answer][:accept]
          answer_user = question.accepted_answer.user
          question.reload
          Reputation.toggle_acceptance(question, question.answers.last)
          question.reload
          answer_user.reload
          question.accepted_answer.should be_nil
          answer_user.reputation.should == 0
        end
      end
 
      describe "revokes acceptance of his own answer" do
        before do
          question.answers << Factory.build(:answer, :user => question.user)
          question.save
          Reputation.toggle_acceptance(question, question.answers.last)
        end
        it "so the question has no accepted answer anymore" do 
          Reputation.toggle_acceptance(question, question.answers.last)
          question.reload
          question.accepted_answer.should be_nil
          question.user.reputation.should == 0
        end
      end

      describe "accepts an answer" do
        before do
          question.answers << Factory.build(:answer, :user => Factory.create(:user2))
          question.save
        end
        it "so the question has an accepted answer and the answer owner gains some reputation" do
          Reputation.toggle_acceptance(question, question.answers.first)
          question.reload
          question.accepted_answer.should == question.answers.first
          question.user.should_not == question.accepted_answer.user
          question.accepted_answer.user.reputation.should == Smartr::Settings[:reputation][:answer][:accept]
        end
      end       

      describe " " do

      end
    end
  end
  
  
end