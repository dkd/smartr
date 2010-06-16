require 'test_helper'

class Admin::AnswersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer" do
    assert_difference('Admin::Answer.count') do
      post :create, :answer => { }
    end

    assert_redirected_to answer_path(assigns(:answer))
  end

  test "should show answer" do
    get :show, :id => admin_answers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_answers(:one).to_param
    assert_response :success
  end

  test "should update answer" do
    put :update, :id => admin_answers(:one).to_param, :answer => { }
    assert_redirected_to answer_path(assigns(:answer))
  end

  test "should destroy answer" do
    assert_difference('Admin::Answer.count', -1) do
      delete :destroy, :id => admin_answers(:one).to_param
    end

    assert_redirected_to admin_answers_path
  end
end
