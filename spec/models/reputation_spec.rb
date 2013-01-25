require 'spec_helper'

describe Reputation do
  
  context "Answer: " do
    context "When upvoted" do
      
      describe "from a user" do
        let(:answer) { FactoryGirl.create(:endless_answer_with_question)}
        let(:user) { FactoryGirl.create(:endless_user) }
        it "will increase the reputation of the owner of the answer while the voter's reputation remains the same" do
          answer.user.reputation.should == 0
          user_reputation = user.reputation
          vote = FactoryGirl.create(:vote, :user => user, :voteable => answer, :value => "1")
          answer.user.reload.reputation.should == Smartr::Settings[:reputation][:answer][:up]
          user.reload.reputation == user_reputation
        end
      end

      describe "from a user who previously downvoted this answer" do
        let(:answer) { FactoryGirl.create(:endless_answer_with_question)}
        let(:user) { FactoryGirl.create(:endless_user, :reputation => 100) }
        it "then will unpenalize the voter and increase the reputation of the answer's owner" do
          answer_owner_reputation = answer.user.reputation
          vote = FactoryGirl.create(:vote, :user => user, :voteable => answer, :value => "-1")
          vote.value = "1" 
          vote.save
          answer.user.reload.reputation.should  == answer_owner_reputation + Smartr::Settings[:reputation][:answer][:up]
          user.reload.reputation == 100 + Smartr::Settings[:reputation][:answer][:penalty].to_i.abs
        end
      end
      
    end
    
    context "When downvoted" do
      let(:answer) { FactoryGirl.create(:endless_answer_with_question)}
      describe "from a user with zero reputation" do
        let(:user) { FactoryGirl.create(:endless_user, :reputation => 0) }
        it "will reduce the answer's reputation while the voter's reputation remains at zero" do
          answer.user.reputation = 1000
          answer.user.save
          user.reputation.should == 0
          vote_down = FactoryGirl.create(:vote, :user => user, :voteable => answer, :value => "-1")
          answer.user.reload.reputation.should == 1000 + Smartr::Settings[:reputation][:answer][:down].to_i
          user.reload.reputation.should == 0
        end
      end

      describe "from a user with reputation" do
        let(:user) { FactoryGirl.create(:endless_user, :reputation => 100) }
        it "will reduces the reputation of the answer owner and the voter' reputation gets penalized" do
          answer.user.reputation = 1000
          answer.user.save
          vote_down = FactoryGirl.create(:vote, :user => user, :voteable => answer, :value => "-1")
          answer.user.reputation.should == 1000 + Smartr::Settings[:reputation][:answer][:down].to_i
          user.reputation.should == 100 + Smartr::Settings[:reputation][:answer][:penalty].to_i
        end
      end

      describe "from a user who previously upvoted this answer" do
        let(:user) { FactoryGirl.create(:endless_user, :reputation => 100) }
        it "will decrease the reputation of the answer's owner while the voter's reputation doesn't change" do
          answer.user.reputation = 1000
          answer.user.save
          vote = FactoryGirl.create(:vote, :user => user, :voteable => answer, :value => "1")
          answer.user.reputation.should == 1000 + Smartr::Settings[:reputation][:answer][:up].to_i
          user.reputation.should == 100
          vote.reload.value = "-1"
          vote.save
          user.reload.reputation.should == 100
          answer.user.reload.reputation.should == (1000 + Smartr::Settings[:reputation][:answer][:up].to_i) + Smartr::Settings[:reputation][:answer][:down].to_i
        end
      end
    end  
    
  end
  
  
  context "Question acceptance:" do
    describe "the question owner" do
      let(:question) { FactoryGirl.create(:question2)}
      describe "accepts his own answer" do
        before do
          question.answers << FactoryGirl.build(:answer, :user => question.user)
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
          question.answers << FactoryGirl.build(:answer, :user => FactoryGirl.create(:user2))
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
          question.answers << FactoryGirl.build(:answer, :user => question.user)
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
      
      describe "reject an answer" do
        pending "so the question has no accepted answer and the reputation of the answer's owner will be reset"
      end

      describe "accepts an answer" do
        before do
          question.answers << FactoryGirl.build(:answer, :user => FactoryGirl.create(:user2))
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