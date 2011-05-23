require "spec_helper"

describe AnswersController do
  describe "routing" do
    it "recognizes and generates #create" do
      { :post => "/comments" }.should route_to(:controller => "comments", :action => "create")
    end
    it "recognizes and generates #edit" do
      { :get => "/comments/1/edit" }.should route_to(:controller => "comments", :action => "edit", :id => "1")
    end
    it "recognizes and generates #update" do
      { :put => "/comments/1" }.should route_to(:controller => "comments", :action => "update", :id => "1")
    end
    it "recognizes and generates #new" do
      { :get => "/comments/new" }.should route_to(:controller => "comments", :action => "new")
    end
  end
end