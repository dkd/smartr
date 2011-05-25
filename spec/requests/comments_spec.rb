require 'spec_helper'

describe "Comments" do
  describe "GET /comments" do
    it "does not exist" do
      get comments_path
      response.should_not be_successful
    end
  end
end
