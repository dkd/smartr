require File.dirname(__FILE__) + '/../spec_helper'


module QuestionSpecHelper
  
  def valid_question(options = {})
    @valid_question = Factory.build(:question, options)
  end

end
  
describe Question do
  include QuestionSpecHelper
  
  context "Validations" do
    
    it "should be valid given valid attributes" do
      #q = valid_question
      #q.should be_valid
    end
    
    it "should have a unique name" do
      #q1 = valid_question
      #q1.save!
      #q2 = valid_question
      #q2.should have(1).error_on :name
    end
    
    it "should be invalid without a body"
    
  end
  
  it "should generate a valid permalink" do    
    #q = valid_question(:name => "I will be a valid permalink with just enough chars")
    #q.permalink.should == "I will be a valid permalink with just enough chars".to_permalink
  end
  
  
end

