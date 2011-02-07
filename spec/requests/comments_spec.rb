require 'spec_helper'

describe "Comments" do
  describe "GET /comments" do
    it "does not exist" do
      get comments_path
      response.should_not be_successful
    end
  end
  
  describe "GET /comments/new" do
    it "works!" do
      xhr :get, new_comment_path
      response.should be_successful
    end
  end
end
