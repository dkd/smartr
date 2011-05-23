require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers
  render_views
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
  context "unauthorized" do
    describe "GET new" do
      it "shows the login page" do
        get :new
          response.should be_success
      end
    end
  end
  context "authorized" do
    let (:user) { Factory(:endless_user)}
    describe "GET new" do
      before do
        sign_in user
      end
      it "shows the login page" do
        get :new
          response.should redirect_to root_url
          flash[:alert].should eq(I18n.t("devise.failure.already_authenticated"))
      end
    end
  end
end
