require "spec_helper"

describe Api::V1::QuestionsController do
  include Devise::TestHelpers
  let(:question) { FactoryGirl.create :question2 }
 
  describe "GET index" do
    it "has a 200 status code" do
      get :index, :format => :json
      response.code.should eq("200")
    end
  end
end