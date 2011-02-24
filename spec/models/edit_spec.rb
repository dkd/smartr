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
      
      pending "it should not have more than 255 chars"
      pending "it should have at least 10 chars"
      
    end
    
    describe "of user" do
      
      pending "it should be either the owner of editable or an admin"
      
    end
    
  end
  
end
