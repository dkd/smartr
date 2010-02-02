require File.dirname(__FILE__) + '/../spec_helper'

module UserSpecHelper
  
  def valid_user(options = {})
    @valid_user = Factory(:user, options)
  end
  
  def logged_in_user
    @logged_in_user = Factory(:user, options)
    UserSession.create(@logged_in_user)
  end
  
end


describe User do
  include UserSpecHelper
  setup :activate_authlogic
  
  context "Validations" do
    
    it "should be valid given valid attributes" do
    
      user = valid_user
      user.should be_valid
    
    end
    
    it "should be invalid without an email address" do
      user = valid_user
      user.email = nil
      user.should be_invalid
    end
    
    it "should create a new user_session"
    

  end
end
