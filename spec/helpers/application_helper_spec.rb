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
  
  describe "button_tag"  do
    
    it "returns a button submit tag with a class" do
      content = helper.t("save")
      helper.button_tag("save", :type => :submit, :class => "some-class").should  eq('<button class="some-class" type="submit">'+content+'</button>')
    end
    
  end
  
end