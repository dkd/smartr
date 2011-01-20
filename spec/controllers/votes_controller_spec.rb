require "spec_helper"

describe VotesController do
  include Devise::TestHelpers
  
  context "As a user who is" do

    context "not logged in" do
      describe "he votes on a question" do
        it "and fails" do
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