require 'spec_helper'

describe AnswersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/answers" }.should route_to(:controller => "answers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/answers/new" }.should route_to(:controller => "answers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/answers/1" }.should route_to(:controller => "answers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/answers/1/edit" }.should route_to(:controller => "answers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/answers" }.should route_to(:controller => "answers", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/answers/1" }.should route_to(:controller => "answers", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/answers/1" }.should route_to(:controller => "answers", :action => "destroy", :id => "1") 
    end
  end
end
