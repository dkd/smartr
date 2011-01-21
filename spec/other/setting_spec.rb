require 'spec_helper'

describe "Settings" do
  context "Reputation" do 
    describe " on answers" do
      it "it should have an have numerical values" do
        answer = Smartr::Settings[:reputation][:answer]
        answer[:up].should be_an_integer
        answer[:down].should be_an_integer
        answer[:penalty].should be_an_integer
        answer[:accept].should be_an_integer
      end
    end
    describe " on answers" do
      it "it should have an have numerical values" do
        question = Smartr::Settings[:reputation][:question]
        question[:up].should be_an_integer
        question[:down].should be_an_integer
        question[:penalty].should be_an_integer
        question[:new].should be_an_integer
      end
    end
    describe " on comments" do
      it "it should have an have numerical values" do
        comment = Smartr::Settings[:reputation][:comment]
        comment[:up].should be_an_integer
        comment[:down].should be_an_integer
        comment[:penalty].should be_an_integer
      end
    end
  end
end