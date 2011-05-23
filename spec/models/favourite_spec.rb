require 'spec_helper'

describe Favourite do
  describe "relations" do
    it { should belong_to :user }
    it { should belong_to :question }
  end
  describe "validation of" do
    describe "user" do
      it {should validate_presence_of :user}
    end
    describe "question" do
      it {should validate_presence_of :user}
    end
  end  
  
end