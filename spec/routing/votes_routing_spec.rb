require "spec_helper"

describe VotesController do
  
  describe "routing" do
    
    it "recognizes and generates #put" do
      { :put => "/votes" }.should route_to(:controller => "votes", 
                                              :action => "update",
                                              :id => "1",
                                              :model => "question")
    end
    
  end

end