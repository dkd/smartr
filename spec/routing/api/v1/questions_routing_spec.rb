require "spec_helper"

describe QuestionsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/api/v1//questions" }.should route_to(:controller => "api/v1/questions", :action => "index")
    end
  end
end