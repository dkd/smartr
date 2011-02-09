require "spec_helper"

describe Admin::UsersController do
  include Devise::TestHelpers
  let(:user) {Factory.create(:user)}
  let(:admin) { Factory.create(:endless_user, :is_admin => true)}
  render_views
  
  context "unauthorized user" do

    describe "GET :index" do
      it "requires an admin" do
        sign_in user
        get :index
        response.should_not be_successful
        response.should redirect_to(root_url)
      end
    end
    
    describe "GET :show" do
      it "requires an admin" do
        sign_in user
        get :show, :id => Factory(:endless_user)
        response.should_not be_successful
        response.should redirect_to(root_url)
      end
    end
    
    describe "GET :new" do
      it "requires an admin" do
        sign_in user
        get :new
        response.should_not be_successful
        response.should redirect_to(root_url)
      end
    end
    
    describe "GET :edit" do
      it "requires an admin" do
        sign_in user
        get :edit, :id => user.id
        response.should_not be_successful
        response.should redirect_to(root_url)
      end
    end
    
    describe "PUT :update" do
      it "requires an admin" do
        sign_in user
        put :update, :id => user.id
        response.should_not be_successful
        response.should redirect_to(root_url)
      end
    end
    
    describe "POST :create" do
      it "requires an admin" do
        sign_in user
        put :update, :id => user.id
        response.should_not be_successful
      end
    end
    
  end
  
  context "authorized access" do
    
    describe "GET :index" do
      it "show the user list" do
        sign_in admin
        get :index
        response.should be_successful
      end
    end
    
    describe "GET :show" do
      it "shows the user" do
        sign_in admin
        get :show, :id => user.id
        response.should be_successful
      end
    end
    
    describe "GET :new" do
      it "loads the new user form" do
        sign_in admin
        get :new
        response.should be_successful
      end
    end
    
    describe "GET :edit" do
      it "requires an admin" do
        sign_in admin
        get :edit, :id => user.id
        response.should be_successful
      end
    end
    
    describe "PUT :update" do
      describe "with valid params" do
        it "shows the user page" do
          sign_in admin
          put :update, :id => user.id, :user => {:login => "joe-average"}
          response.should redirect_to(admin_user_path(:id => "joe-average"))
        end
      end
      describe "with invalid params" do
        it "shows the user page" do
          sign_in admin
          put :update, :id => user.id, :user => {:login => "   "}
          response.should render_template(:edit)
        end
      end
   end
   describe "POST :create" do
     describe "with valid params" do
      it "requires an admin" do
        sign_in admin
        post :create, :user => {:login => "joe-average", :email => Faker::Internet.email, :password => "sdasihf22", :password_confirmation => "sdasihf22"}
        response.should redirect_to(admin_user_path(:id => "joe-average"))
      end
    end
      describe "with invalid params" do
        it "shows the new user form" do
          sign_in admin
          post :create
          response.should render_template(:new)
        end
      end
    end
    
  end

end