require 'test_helper'

class Admin::QuestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Admin::Question.count') do
      post :create, :question => { }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    get :show, :id => admin_questions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_questions(:one).to_param
    assert_response :success
  end

  test "should update question" do
    put :update, :id => admin_questions(:one).to_param, :question => { }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    assert_difference('Admin::Question.count', -1) do
      delete :destroy, :id => admin_questions(:one).to_param
    end

    assert_redirected_to admin_questions_path
  end
end
