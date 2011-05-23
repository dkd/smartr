require "spec_helper"

describe QuestionsController do

  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "questions", :action => "index")
      { :get => "/questions" }.should route_to(:controller => "questions", :action => "index")
    end
    
    it "recognizes and generates #show" do
      { :get => "/questions/1" }.should route_to(:controller => "questions", :action => "show", :id => "1")
      { :get => "/questions/1/i-am-a-friendly_id" }.should route_to(:controller => "questions", :action => "show", :id => "1", :friendly_id => "i-am-a-friendly_id")
    end
    
    it "recognizes and generates #new" do
      { :get => "/questions/new" }.should route_to(:controller => "questions", :action => "new")
    end
    
    it "recognizes and generates #edit" do
      { :get => "/questions/1/i-am-a-friendly_id/edit" }.should route_to(:controller => "questions", :action => "edit", :id => "1", :friendly_id => "i-am-a-friendly_id")
    end
    
    it "recognizes and generates #create" do
      { :post => "/questions" }.should route_to(:controller => "questions", :action => "create")
    end
    
    it "recognizes and generates #update" do
      { :put => "/questions/1" }.should route_to(:controller => "questions", :action => "update", :id => "1")
    end
    
  end
  
end