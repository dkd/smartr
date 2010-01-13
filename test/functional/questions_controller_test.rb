require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  test "showing homepage" do
    assert_response :success
  end
  
  test "should not be able to create question without user logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "logged in user should be able to enter a question" do
    UserSession.create Factory.build(:user)
    get :new
    assert_response :success
  end
  
  test "Logged in user should not be able to save empty question" do
    UserSession.create Factory.build(:user)
    get :new
    assert_response :success
    post :create
    #assert_redirected_to question_path(controller.instance_variable_get :@question)
    assert_template :new
  end
  
  test "Show question" do
    Factory(:question)
    get :show, :id => Question.last.id
  end
  
end
 