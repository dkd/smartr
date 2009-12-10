require 'spec'
require 'spec_helper'

describe Question do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :body => "value for body",
      :user_id => 1,
      :views => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@valid_attributes)
  end
  
  it "should have at least one tag"
    puts "SPEC"
  end  
  
end
