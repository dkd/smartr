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
    post :create, :controller => :user_sessions, :user_session => { :login => "bjohnson", :password => "benrocks" }
    get :new
    assert_redirected_to new_question_path
  end
  
end
 