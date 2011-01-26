require "spec_helper"

describe Api::V1::QuestionsController do
  include Devise::TestHelpers
  let(:question) {Factory.create :question2}
  render_views
  
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      response.code.should eq("200")
    end
  end
end