require "spec_helper"

describe UsersController do
  include Devise::TestHelpers
  
  describe "GET :index" do
    before do
      Factory.create(:user)
    end
   
    it "shows the users list" do
      get :index
      response.should be_success
      assigns(:users).count.should eq(1)
      response.should render_template(:index)
    end
  end
  
  describe "GET :search" do
    let(:user) {Factory.create(:user)}
    it "shows the searched user" do
      get :index, :q => user.login
      response.should be_success
      response.should render_template(:index)
    end
    it "shows the searched user (AJAX)" do
      xhr :get, :index, :q => user.login
      response.should be_success
      response.should render_template(:index)
    end
  end
  
  describe "GET :who_is_online" do
    let(:user) {Factory.create(:user)}
    
    it "shows the people online" do
      sign_in user
      get :who_is_online
      response.should be_success
      assigns(:users).size.should eq(User.online.size)
      response.should render_template(:who_is_online)
    end
    
    it "shows the reputation history of the user" do
      sign_in user
      get :reputation, :id => user.id
      response.should be_success
      assigns(:user).should eq(user)
      response.should render_template(:reputation)
    end
    
  end
  
  describe "An authorized User" do
    let(:user) {Factory.create(:user)}
    before do
      sign_in user
    end
    
    #describe "edits his account" do
    #  it "and sees the edit form" do
    #    get :edit, :id => user.id
    #    response.should be_success
    #    response.should render_template("users/devise/registrations/edit")
    #  end
    #end
    
  end
  
  describe "An unauthorized User" do
    let(:user) {Factory.create(:user)}
    
    describe "tries to edit an account" do
      it "should not load the edit form" do
        get :edit, :id => user.id
        response.should_not be_success
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end
    
    describe "tries to post an update to an user account" do
      it "should not load the edit form" do
        put :update, :id => user.id
        response.should_not be_success
        response.should redirect_to(:controller => "devise/sessions", :action => "new")
      end
    end
    
  end
  
  
  describe "Counting number of users online within the last 5 minutes" do
    
    describe "with no user" do
      it "counts to zero" do
        get :index
        User.online.size.should eq(0)
      end
    end
    
    describe "with one user" do
      before do
        sign_in Factory(:user)
      end
     
      it "counts to one" do
        get :index
        User.online.size.should eq(1)
      end
    end
    
    describe "with more than one user" do
      let(:user) {Factory.create(:user)}
      let(:user2) {Factory.create(:user2)}
      
      it "counts to 2" do
        sign_in user
        get :show, :id => user.id
        sign_out user
        sign_in user2
        get :show, :id => user2.id
        User.online.size.should eq(2)
      end
    end
    
  end
  
end