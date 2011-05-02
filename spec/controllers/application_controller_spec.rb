require "spec_helper"

describe ApplicationController do
  include Devise::TestHelpers
  context "Authentication" do
    describe "is_admin?" do
      it "should return true if user is an admin" do
        controller do
          user = Factory.create(:endless_user, :is_admin => true)
          sign_in user
          is_admin?(user).should eq(true)
          
        end
      end
      it "should return false if user is not an admin" do
        controller do
          user = Factory.create(:endless_user, :is_admin => false)
          sign_in user
          is_admin?(user).should eq(false)
        end
      end
    end
  end
end