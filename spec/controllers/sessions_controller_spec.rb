require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers
  render_views
  let (:user) { FactoryGirl.create(:endless_user)}
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
    context "invalid params" do
      describe "POST create" do
        it "should show the login form" do
          post :create
          response.should render_template("users/sessions/new")
          flash[:alert].should eq(I18n.t("devise.failure.invalid"))
        end
      end 
    end
    context "valid params" do
      describe "POST create" do
        it "should redirect to the homepage" do
          post :create, :user => { :login => user.login, :password => "leanderTaler3000" }
          controller.current_user.should eq(user)
          response.should redirect_to root_url
        end
      end
    end
  end

  context "authorized" do
    before do
      sign_in user
    end
    describe "GET new" do
      it "shows the login page" do
        get :new
        response.should redirect_to root_url
        flash[:alert].should eq(I18n.t("devise.failure.already_authenticated"))
      end
    end
    describe "GET destroy" do
      it "redirects to the homepage" do
        get :destroy
        flash[:notice].should eq(I18n.t("devise.sessions.signed_out"))
        response.should redirect_to root_url
      end
    end
  end
end
