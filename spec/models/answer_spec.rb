require 'spec_helper'

describe Answer do
  let(:answer) {Factory.create :answer}
  describe "Validations of" do
    
    describe "of body" do
      it "requires presence" do
        answer = Factory.build(:answer, :body => nil)
        answer.should_not be_valid
      end
      
      it "requires a minimum length of 75 characters" do
        answer = Factory.build(:answer, :body => "This answer is too short!")
        answer.should_not be_valid
      end
      
      it "cannot be longer than 2048 characters" do
        answer = Factory.build(:answer, :body => "a"*2049)
        answer.should_not be_valid
      end
      
    end
    
  end
end
