require 'spec_helper'

describe Vote do
  describe "relations" do
    it { should belong_to :user }
    it { should belong_to :voteable }
  end

  context "Question voting:" do
    let(:question) { Factory.create(:question2)}
    let(:user) { Factory.create(:user2, :reputation => 100)}
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
      it "does not result in a negative reputation but" do
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

    describe "5 downvotes on a user with high reputation" do
      it "results in reduced reputation" do
        question.user.reputation = 1000
        question.user.save(:validate => false)
        question.user.reputation.should == 1000
        1.upto(5).each do |n|
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("Question", question.id, Factory(:endless_user, :reputation => 100).id)
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

    context "Comment voting:" do


    end

    describe "validation" do
      describe "of direction" do
        let(:vote) { Factory.build(:vote, :voteable => Factory(:question2), :user => Factory(:endless_user)) }
        describe "should either go up or down" do
          it "accepts up" do
            vote.value = 1
            vote.direction = "up"
            vote.should be_valid
          end
          it "accepts down" do
            vote.value = -1
            vote.direction = "down"
            vote.should be_valid
          end
        end
      end
    end
  end
end