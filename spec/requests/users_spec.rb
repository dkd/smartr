require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "works!" do
      get users_path
      response.should be_successful
    end
  end
end
