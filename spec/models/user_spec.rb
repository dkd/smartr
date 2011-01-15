require 'spec_helper'

describe User do
  let(:user) {Factory.create :user}
  describe "validation" do
    
    describe "of passwords" do
    
      it "fails if password doesn't match confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "nope")
        user.should_not be_valid
      end
    
      it "succeeds if password matches confirmation" do
        user = Factory.build(:user, :password => "password", :password_confirmation => "password")
        user.should be_valid
      end
    
    end
  
    describe "of login name"  do
      
      it "requires presence" do
        user = Factory.build(:user, :login => nil)
        user.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :login => user.login)
        duplicate_user.should_not be_valid
      end
      
      it "downcases login name" do
        user = Factory.build(:user, :login => "eLiTeHackR")
        user.should be_valid
        user.login.should == "eLiTeHackR".downcase
      end
      
      it "fails if the requested login name is only different in case from an existing username" do
        duplicate_user = Factory.build(:user, :login => user.login.upcase)
        duplicate_user.should_not be_valid
      end

      it "strips leading and trailing whitespace" do
        user = Factory.build(:user, :login => " leandertaler ")
        user.should be_valid
        user.login.should == "leandertaler"
      end
    
    end
    
    describe "of email"  do
      
      it "requires presence" do
        user = Factory.build(:user, :email => nil)
        user.should_not be_valid
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :email => user.email)
        duplicate_user.should_not be_valid
      end
    
    end
  
  end

end