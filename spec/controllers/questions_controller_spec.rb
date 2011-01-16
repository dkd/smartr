require "spec_helper"

describe QuestionsController do
  include Devise::TestHelpers
  let(:question) {Factory.create :question2}
  render_views
  
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      response.code.should eq("200")
    end
  end
  
  describe "GET show" do
    it "should should show the question" do
      get :show, :id => question.id
      response.code.should eq("200")
    end

  end
  
end 