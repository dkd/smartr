require "spec_helper"

describe ApplicationHelper do
  
  describe "direction" do
    it "returns up" do
      helper.direction(1).should == "up"
    end
    it "returns down" do
      helper.direction("sdsad").should == "down"
    end
  end
end 