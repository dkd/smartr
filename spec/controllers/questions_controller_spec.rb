require "spec_helper"

describe QuestionsController do
  include Devise::TestHelpers
  let(:question) {Factory.create :question2}
  render_views
  
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      response.code.should eq("200")
    end
  end
  
  describe "GET show" do
    it "should should show the question" do
      get :show, :id => question.id
      response.code.should eq("200")
      assigns(:question).should eq(question)
    end

  end
  
  context "Unauthorized" do
    
    describe "GET new" do
      it "should redirect to the login page" do
        get :new
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
    describe "POST question" do
      it "should redirect to the login page" do
        post :create
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
    describe "PUT question" do
      it "should redirect to the login page" do
        post :update, :id => question.id
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
  end
end 