require "spec_helper"

describe UsersController do
  include Devise::TestHelpers
  
  describe "Counting number of users online within the last 5 minutes" do
    
    describe "with no user" do
      it "counts to zero" do
        get :index
        User.online.size.should eq(0)
      end
    end
    
    describe "with one user" do
      before do
        sign_in Factory(:user)
      end
     
      it "counts to one" do
        get :index
        User.online.size.should eq(1)
      end
    end
    
    describe "with more than one user" do
      let(:user) {Factory.create(:user)}
      let(:user2) {Factory.create(:user2)}
      
      it "counts to 2" do
        sign_in user
        get :show, :id => user.id
        sign_out user
        sign_in user2
        get :show, :id => user2.id
        User.online.size.should eq(2)
      end
    end
    
  end
  
end