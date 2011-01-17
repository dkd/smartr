require "spec_helper"

describe TagsController do
  include Devise::TestHelpers
  let(:question) {Factory.create :question2}
  render_views
  
  context "HTML" do
    describe "GET index" do
       it "has a 200 status code" do
         get :index
         response.code.should eq("200")
       end
     end

     describe "GET index Search" do
       it "has a 200 status code" do
         get :index, :tags => {:q => "ruby"}
         response.code.should eq("200")
         assigns(:q).should eq("ruby")
       end
     end
  end
 
  context "AJAX" do
    describe "GET index" do
      it "has a 200 status code" do
        xhr :get, :index
        response.code.should eq("200")
      end
    end
  
    describe "AJAX GET index search" do
      it "has a 200 status code" do
        xhr :get, :index, :tags => {:q => "ruby"}
        response.code.should eq("200")
        assigns(:q).should eq("ruby")
      end
    end
  end
end