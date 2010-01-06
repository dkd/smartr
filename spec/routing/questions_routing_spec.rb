require 'spec_helper'

describe QuestionsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/questions" }.should route_to(:controller => "questions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/questions/new" }.should route_to(:controller => "questions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/questions/1" }.should route_to(:controller => "questions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/questions/1/edit" }.should route_to(:controller => "questions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/questions" }.should route_to(:controller => "questions", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/questions/1" }.should route_to(:controller => "questions", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/questions/1" }.should route_to(:controller => "questions", :action => "destroy", :id => "1") 
    end
  end
end
