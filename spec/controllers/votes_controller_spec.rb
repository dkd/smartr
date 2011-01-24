require "spec_helper"

describe VotesController do
  include Devise::TestHelpers
 
  describe "As a user who is" do

    context "not logged in" do
      describe "he votes on a question" do
        it "and fails" do
          xhr :put, :update, :id => 1000
          response.should render_template("shared/not_authorized")
        end 
      end
    end
    
    context "logged in" do
      let(:user2) {Factory.create :user2}
      before do
        sign_in user2
      end
      
      describe "and votes up a question" do
        let(:question) { Factory.create :question2 }
        describe "he already voted up" do
          before do
            vote = Factory.build(:vote)
            vote.user = user2
            vote.voteable = question
            vote.value = 1
            vote.save
          end
          it "and fails" do
            
          end
        end
      end

    end

  end
end