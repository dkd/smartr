require File.dirname(__FILE__) + '/../spec_helper'

module QuestionsControllerSpecHelper
  
  def valid_user(options = {})
    @valid_user = Factory(:user)
    UserSession.create(@valid_user)
  end
  
end

describe QuestionsController do
  include QuestionsControllerSpecHelper
  setup :activate_authlogic
  
  context "Validations" do
  
    it "should redirect to login if user is not authenticated and tries to create a new question" do
      get :new
      response.should redirect_to new_user_session_path
    end
    
    it "should show new question page if user is authenticated" do
     valid_user
     get :new
     response.should be_success
    end
  
    it "should not allow the user to vote on his own question"
    it "should not be allowed to vote without an ajax call"
  
  end

end