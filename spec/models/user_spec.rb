require File.dirname(__FILE__) + '/../spec_helper'

module UserSpecHelper
  
  def valid_user(options = {})
    Factory(:user, options)
  end
  
  def logged_in_user
    @logged_in_user = Factory(:user, options)
    UserSession.create(@logged_in_user)
  end
  
end


describe User do
  include UserSpecHelper
  #setup :activate_authlogic
  
  context "Validations" do
    
    it "should be valid given valid attributes" do
      user = User.new
      user.email = "kieran@example.com"
      user.password = "12345ZZZZZAAA"
      user.password_confirmation = "12345ZZZZZAAA"
      user.login = "kieran"
      user.should be_valid
    end
    
    it "should be invalid without a correct email address" do
      user = User.new
      user.email = "kieran@example.comasfas"
      user.password = "12345ZZZZZAAA"
      user.password_confirmation = "12345ZZZZZAAA"
      user.login = "kieran"
      user.should be_invalid
    end
    
  end
  
  context "Questions" do
    
    it "should have a question"
      user = @valid_user
      #user.questions.length should_be 1
    end

  end

