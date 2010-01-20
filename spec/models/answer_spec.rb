require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Answer do
  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :question_id => 1,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Answer.create!(@valid_attributes)
  end
end
