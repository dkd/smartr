require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers
  render_views
  context "unauthorized" do
    describe "GET new" do
      it "shows the login page" do
        get :new
          response.should be_success
      end
    end
  end
  context "authorized" do
    describe "GET new" do
      it "shows the login page" do
        get "/users/sign_in"
          response.should be_success
      end
    end
  end
end
