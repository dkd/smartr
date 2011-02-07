require 'spec_helper'

describe "Questions" do
  describe "GET /api/v1/questions" do
    it "works!" do
      get api_v1_questions_path
      response.should be_successful
    end
  end
end
