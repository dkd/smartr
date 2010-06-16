require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('Admin::User.count') do
      post :create, :user => { }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => admin_users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_users(:one).to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => admin_users(:one).to_param, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('Admin::User.count', -1) do
      delete :destroy, :id => admin_users(:one).to_param
    end

    assert_redirected_to admin_users_path
  end
end
