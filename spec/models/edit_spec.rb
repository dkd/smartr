require 'spec_helper'

describe Edit do
  it { should belong_to :editable }
  it { should belong_to :user }
  it { should validate_presence_of :body }
  it { should validate_presence_of :editable }
  it { should ensure_length_of :body }
  
  describe "validation" do
    let(:question) { Factory.create :question2 }
    
    describe "of body" do
      it "should not have more than 255 chars" do
        edit = Factory.build(:edit, :editable => question, :body => "a"*256)
        edit.should_not be_valid
      end
      it "should have at least 10 chars" do
        edit = Factory.build(:edit, :editable => question, :body => "a"*9)
        edit.should_not be_valid
      end
    end
    
    describe "of user" do
      
      pending "it should be either the owner of editable or an admin"
      
    end
    
  end
  
end
