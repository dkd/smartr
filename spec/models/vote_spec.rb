require 'spec_helper'

describe Vote do
  describe "relations" do
    it { 
        should belong_to :user
        should belong_to :voteable
      }  
  end

  describe "validation" do
    describe "of direction" do
      let(:vote) { Factory.build(:vote) }
      describe "should either go up or down" do 
        it "requires presence" do
          vote.should_not be_valid
        end
        it "accepts up" do
          vote.direction = "up"
          vote.should be_valid
        end
        it "accepts down" do
          vote.direction = "down"
          vote.should be_valid
        end
      end
    end
  end
  
end