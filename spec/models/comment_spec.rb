require 'spec_helper'

describe Comment do
  describe "relations" do
    its(:commentable) { should be_nil }
    it { should have(0).votes }
    it { should validate_presence_of :body }
    it { should ensure_length_of :body }
    it { should belong_to :user }
    it { should belong_to :commentable }
    it { should have_many :votes }
  end
  describe "Validations of" do
  
    describe "body" do
      let(:comment) { Factory.build :comment }
      
      it "requires presence" do
        comment.body = nil
        comment.should_not be_valid
      end

      it "requires a minimum length" do
        comment.body = "Too short!"
        comment.should_not be_valid
      end
      
      it "does not allow to many chars" do
        comment.body = "a"*281
        comment.should_not be_valid
      end
      
    end
  
  end
  
end