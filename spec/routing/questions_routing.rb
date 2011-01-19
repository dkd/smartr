require "spec_helper"

describe QuestionsController do
  
  let(:question){ Factory.create :question2 }
  
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "questions", :action => "index")
      { :get => "/questions" }.should route_to(:controller => "questions", :action => "index")
    end
    
    
    
  end
  
end