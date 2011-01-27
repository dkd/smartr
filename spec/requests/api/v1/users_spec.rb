require 'spec_helper'

describe "Users" do
  describe "GET /api/v1/users" do
    it "works!" do
      get api_v1_users_path
    end
  end
end
