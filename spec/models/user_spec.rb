require File.dirname(__FILE__) + '/../spec_helper'

module UserSpecHelper
  
  def valid_user(options = {})
    @valid_user = Factory(:user, options)
  end
  
end


describe User do
  include UserSpecHelper
  
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
    
  end
    
end
