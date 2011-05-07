require "spec_helper"

describe CommentsHelper do
  include Devise::TestHelpers
  before do 
    question = Factory :question
    
    comment_with_reputation = Factory(:random_comment, 
                                      :user => Factory(:endless_user), 
                                      :commentable => question)
                                      
    latest_comment = Factory(:random_comment, 
                             :user => Factory(:endless_user), 
                             :commentable => question)
  end
  describe "order by reputation" do
    
    it "should have the reputation link active" do
      
    end

  end
  
  describe "order by latest" do
    
    it "should have the latest link active" do
      
    end

  end
end