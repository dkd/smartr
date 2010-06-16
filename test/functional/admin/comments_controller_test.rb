require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Admin::Comment.count') do
      post :create, :comment => { }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    get :show, :id => admin_comments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_comments(:one).to_param
    assert_response :success
  end

  test "should update comment" do
    put :update, :id => admin_comments(:one).to_param, :comment => { }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Admin::Comment.count', -1) do
      delete :destroy, :id => admin_comments(:one).to_param
    end

    assert_redirected_to admin_comments_path
  end
end
