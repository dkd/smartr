require 'spec_helper'

describe Reputation do
  
  context "Answer: " do
    context "When upvoted" do
      
      describe "from a user" do
        let(:question) { Factory(:question2)}
        let(:user) { Factory(:endless_user) }
        it "will increase the reputation of the owner of the answer while the voter's reputation remains the same" do
          question.user.reputation.should == 0
          user_reputation = user.reputation
          Reputation.set("up", "Question", user , question.user)
          question.user.reload
          user.reload
          question.user.reputation.should == Smartr::Settings[:reputation][:answer][:up]
          user.reputation == user_reputation
        end
      end

      describe "from a user who previously downvoted this answer" do
        let(:question) { Factory(:question2)}
        let(:user) { Factory(:endless_user, :reputation => 100) }
        it "then will unpenalize the voter and increase the reputation of the answer's owner" do
          question_owner_reputation = question.user.reputation
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question".classify, question.id, user.id)
          vote.set("up")
          question.user.reload
          question.user.reputation.should  == question_owner_reputation + Smartr::Settings[:reputation][:answer][:up]
          user.reload
          user.reputation == 100 + Smartr::Settings[:reputation][:answer][:penalty].to_i.abs
        end
      end
      
    end
    
    context "When downvoted" do

      describe "from a user with zero reputation" do
        pending "the answer owner loses points while the voter's reputation remains at zero"
      end

      describe "from a user with reputation" do
        pending "the answer owner loses points and the voter' reputation gets penalized"
      end

      describe "from a user who previously upvoted this answer" do
        pending "then will unpenalize the voter and decrease the reputation of the answer's owner"
      end
    end  
    
  end
  
  
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
          question.user.id.should_not == question.accepted_answer.user.id
          question.accepted_answer.user.reputation.should == Smartr::Settings[:reputation][:answer][:accept]
        end
      end
             
    end
  end
end