require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :login => "ben", :email => "ben@tester.com", :password => "benrocks", :password_confirmation => "benrocks" }
    end
    assert_redirect_to :controller => :users, :action => :show, :id => users(:ben).id
  end
  
  test "should show user" do
    UserSession.create(users(:ben))
    get :show
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(users(:ben))
    get :edit, :id => users(:ben).id
    assert_response :success
  end

  test "should update user" do
    UserSession.create(users(:ben))
    put :update, :id => users(:ben).id, :user => { }
    assert_response :success
  end
end
