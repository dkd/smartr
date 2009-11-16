require 'spec_helper'

describe Vote do
  before(:each) do
    @valid_attributes = {
      :voteable_type => "value for voteable_type",
      :voteable_id => 1,
      :user_id => 1,
      :value => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Vote.create!(@valid_attributes)
  end
end
