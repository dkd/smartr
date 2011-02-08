require 'spec_helper'

describe Reputation do
  
  
  context "Question voting:" do
    let(:question) { Factory.create(:question2)}
    let(:user) { Factory.create(:user2)}
    describe "An upvote" do
      it "increases the reputation" do
        question.user.reputation.should == 0
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, user.id)
        vote.set("up")
        question.votes.count.should == 1
        question.user.reload
        question.user.reputation.should == Smartr::Settings[:reputation][:question][:up]
      end
    end
    describe "An downvote on a user with no reputation" do
      it "does not result in a negative reputation" do
        question.user.reputation.should == 0
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, user.id)
        vote.set("down")
        question.votes.count.should == 1
        question.user.reload
        question.user.reputation.should_not == Smartr::Settings[:reputation][:question][:down]
        question.user.reputation.should == 0
      end
      
      it "puts a penalty on the voter's reputation" do
        user = Factory(:endless_user, :reputation => 100)
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, user.id)
        vote_count = vote.set("down")
        user.reload
        user.reputation.should == (100 + Smartr::Settings[:reputation][:question][:penalty])
      end
      it "puts a penalty on the voter's reputation but not less than zero" do
        user = Factory(:endless_user, :reputation => 0)
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, user.id)
        vote_count = vote.set("down")
        user.reload
        user.reputation.should == 0
      end
    end
    describe "5 upvotes" do
      it "results in a big reputation" do
        question.user.reputation.should == 0
        1.upto(5).each do |n|
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, Factory(:endless_user).id)
          vote_count = vote.set("up")
        end
        question.votes.count.should == 5
        question.user.reload
        question.user.reputation.should == Smartr::Settings[:reputation][:question][:up] * 5
      end
    end
    
    describe "5 downvotes" do
      it "results in zero reputation" do
        question.user.reputation.should == 0
        1.upto(5).each do |n|
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, Factory(:endless_user).id)
          vote_count = vote.set("down")
        end
        question.votes.count.should == 5
        question.user.reload
        question.user.reputation.should == 0
      end
    end
    
    describe "5 downvotes on user with high reputation" do
      it "results in reduced reputation" do
        question.user.reputation = 1000
        question.user.save(:validate => false)
        question.user.reputation.should == 1000
        1.upto(5).each do |n|
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, Factory(:endless_user).id)
          vote_count = vote.set("down")
        end
        question.user.reload
        question.user.reputation.should == 1000 + (Smartr::Settings[:reputation][:question][:down] * 5)
      end
    end
    
    describe "Somebody tries to upvote twice" do
      it "won't work" do
        question.user.reputation.should == 0
        vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, user.id)
        vote_count = vote.set("up")
        question.user.reload
        reputation = question.user.reputation
        question.votes.count.should == 1
        vote.set("up")
        question.votes.reload
        question.user.reload
        question.votes.count.should == 1
        question.user.reputation.should == reputation
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
         question.user.should_not == question.accepted_answer.user
         question.accepted_answer.user.reputation.should == Smartr::Settings[:reputation][:answer][:accept]
       end
     end       

     describe " " do

     end
   end
 end
  
  
end