require "spec_helper"

describe CommentsHelper do
  include Devise::TestHelpers
  before do 
    question = Factory :question
    comment = Factory.create(:random_comment, :commentable => question, :user => Factory(:endless_user))
    comment = Factory.create(:random_comment, :commentable => question, :user => Factory(:endless_user))
    #comment_with_reputation = Factory(:random_comment, 
    #                                  :user => Factory(:endless_user), 
    #                                  :commentable => question,
    #                                  :created_at => (Time.now) - 10.minutes)
    #Factory(:upvote, :voteable => comment_with_reputation, :user => Factory(:endless_user))
    #latest_comment = Factory(:random_comment, 
    #                         :user => Factory(:endless_user), 
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