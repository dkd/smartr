require "spec_helper"

describe AnswersController do
  describe "routing" do
    
    it "recognizes and generates #new" do
      { :get => "/questions/1/some-friendly-id/answers/new" }.should route_to(:controller => "answers", :action => "new", :question_id => "1", :friendly_id => "some-friendly-id")
    end
    
    it "recognizes and generates #edit" do
      { :get => "/questions/1/some-friendly-id/answer/33/edit" }.should route_to(:controller => "answers", :action => "edit", :question_id => "1", :friendly_id => "some-friendly-id", :id => "33")
    end
    
    it "recognizes and generates #create" do
      { :post => "/questions/1/some-friendly-id/answers" }.should route_to(:controller => "answers", :action => "create", :question_id => "1", :friendly_id => "some-friendly-id")
    end
    
    it "recognizes and generates #update" do
      { :post => "/questions/1/some-friendly-id/answer/33" }.should route_to(:controller => "answers", :action => "update", :question_id => "1", :friendly_id => "some-friendly-id", :id => "33")
    end
    
  end
end