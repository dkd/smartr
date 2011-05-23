require 'spec_helper'

describe "Questions" do
  describe "GET /api/v1/questions.json" do
    it "works!" do
      get api_v1_questions_path(:format => :json)
      response.should be_successful
    end
  end
end
