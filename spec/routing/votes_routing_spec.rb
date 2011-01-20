require "spec_helper"

describe VotesController do
  
  describe "routing" do
    
    it "recognizes and generates #put" do
      { :put => "/votes/1" }.should route_to(:controller => "votes", 
                                              :action => "update",
                                              :id => "1"
                                              )
    end
    
  end

end