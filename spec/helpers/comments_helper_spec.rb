require "spec_helper"

describe CommentsHelper do
  include Devise::TestHelpers
  before do 
    question = FactoryGirl.create :question
    comment = FactoryGirl.create(:random_comment, :commentable => question, :user => FactoryGirl.create(:endless_user))
    comment = FactoryGirl.create(:random_comment, :commentable => question, :user => FactoryGirl.create(:endless_user))
    #comment_with_reputation = Factory(:random_comment, 
    #                                  :user => FactoryGirl.create(:endless_user), 
    #                                  :commentable => question,
    #                                  :created_at => (Time.now) - 10.minutes)
    #Factory(:upvote, :voteable => comment_with_reputation, :user => FactoryGirl.create(:endless_user))
    #latest_comment = Factory(:random_comment, 
    #                         :user => FactoryGirl.create(:endless_user), 
    #                         :commentable => question)
  end
  describe "order by reputation" do
    
    it "should have the reputation link active" do
      
      #comments_order_menu.should match(conten_tag(:li,))
    end

  end
  
  describe "order by latest" do
    
    it "should have the latest link active" do
      
    end

  end
end