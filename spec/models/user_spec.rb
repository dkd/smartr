require 'spec_helper'

describe User do
  let(:user) {Factory.create :user}
  
  it { should have_many :questions  
       should have_many :answers    
       should have_many :comments   
       should have_many :favourites 
       should have_many(:interesting_tags).through(:interesting_tag_taggings)
       should have_many(:uninteresting_tags).through(:uninteresting_tag_taggings) 
     }
  
  describe "new user record" do
    
    it "has zero reputation" do
      user = Factory.create(:user2)
      user.reputation.should == 0
    end
    
  end
  
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
        user.should have(3).error_on(:login)
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :login => user.login, :email => Faker::Internet.email)
        duplicate_user.should_not be_valid
        duplicate_user.should have(1).error_on(:login)
      end
      
      it "downcases login name" do
        user = Factory.build(:user, :login => "eLiTeHackR")
        user.should be_valid
        user.login.should == "eLiTeHackR".downcase
      end
      
      it "fails if the requested login name is only different in case from an existing username" do
        duplicate_user = Factory.build(:user, :login => user.login.upcase, :email => Faker::Internet.email)
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
        user = Factory.build(:user, :login => "anotheruser", :email => nil)
        user.should_not be_valid
        user.should have(2).error_on(:email)
      end

      it "requires uniqueness" do
        duplicate_user =  Factory.build(:user, :login => "anotheruser", :email => user.email)
        duplicate_user.should_not be_valid
        duplicate_user.should have(1).error_on(:email)
      end
    
    end
  
  end

end