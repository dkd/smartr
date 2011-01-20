require "spec_helper"

describe VotesController do
  include Devise::TestHelpers
 
  describe "As a user who is" do

    context "not logged in" do
      describe "he votes on a question" do
        it "and fails" do
          xhr :put, :update, :id => 1000
          response.should render_template("shared/not_authorized")
        end 
      end
    end
    
    context "logged in" do

      describe "and votes up a question" do
        describe "he already voted up" do
          it "and fails" do
          end
        end
      end

    end

  end
end