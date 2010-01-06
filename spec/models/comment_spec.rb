require 'spec_helper'

describe Comment do
  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :user_id => 1,
      :commentable_id => 1,
      :commentable_type => "value for commentable_type"
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
end
