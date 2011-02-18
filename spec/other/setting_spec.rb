require 'spec_helper'

describe "Settings" do
  context "Reputation" do 
    describe " on answers" do
      it "it should have an have numerical values" do
        answer = Smartr::Settings[:reputation][:answer]
        answer[:up].should be_a_kind_of(Integer)
        answer[:down].should be_a_kind_of(Integer)
        answer[:penalty].should be_a_kind_of(Integer)
        answer[:accept].should be_a_kind_of(Integer)
      end
      it "should return zero" do
        answer = Smartr::Settings[:reputation][:answer]
        (answer[:penalty].to_i.abs + answer[:penalty]).should == 0
      end
    end
    describe " on answers" do
      it "it should have an have numerical values" do
        question = Smartr::Settings[:reputation][:question]
        question[:up].should be_a_kind_of(Integer)
        question[:down].should be_a_kind_of(Integer)
        question[:penalty].should be_a_kind_of(Integer)
        question[:new].should be_a_kind_of(Integer)
      end
      it "should return zero" do
        question = Smartr::Settings[:reputation][:question]
        (question[:penalty].to_i.abs + question[:penalty]).should == 0
      end
    end
    describe " on comments" do
      it "it should have an have numerical values" do
        comment = Smartr::Settings[:reputation][:comment]
        comment[:up].should be_a_kind_of(Integer)
        comment[:down].should be_a_kind_of(Integer)
        comment[:penalty].should be_a_kind_of(Integer)
      end
      it "should return zero" do
        comment = Smartr::Settings[:reputation][:comment]
        (comment[:penalty].to_i.abs + comment[:penalty]).should == 0
      end
    end
  end
end