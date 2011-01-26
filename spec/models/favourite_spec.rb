require 'spec_helper'

describe Favourite do
  describe "relations" do
    it { should belong_to :user }
    it { should belong_to :question }
  end
  describe "validation of" do
    describe "user" do
      it {should validate_presence_of :user_id}
    end
    describe "question" do
      it {should validate_presence_of :question_id}
    end
  end  
  
end