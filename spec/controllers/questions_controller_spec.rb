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
      get :show, :question_id => question.id, :friendly_id => question.friendly_id
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
    
    describe "DELETE question" do
      it "should redirect to the login page" do
        post :destroy, :id => question.id
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
  end
  
  context "authorized user" do
    before do
      sign_in Factory.create(:user2)
    end
      
    describe "GET new" do
      it "should show the new question page" do
        get :new
        response.should be_success
        response.should render_template(:new)
      end
    end
    
   describe "POST question with correct parameters" do
      it "should redirect to created question" do
        post :create, :question => {:name => "How many PHP Frameworks try to emulate Ruby on Rails?", :body => Faker::Lorem.sentences(10).to_s, :tag_list => "testing, rails, rspec"}
        response.should redirect_to(:controller => "questions", :action => "show", :question_id => Question.last.id, :friendly_id => Question.last.friendly_id)
        assigns(:question).should eq(Question.last)
      end
    end
    
    describe "PUT question with wrong question owner" do
       it "should redirect to question" do
         put :update, :id => question.id
         response.should redirect_to(:controller => "questions", :action => "show", :question_id => question.id, :friendly_id => question.friendly_id)
         assigns(:question).should eq(question)
       end
     end
    
  end

  context "authorized question owner" do
    before do
      sign_in question.user
    end
    
   describe "PUT question with with incorrect parameters" do
       it "should render edit form" do
         put :update, :id => question.id, :question => {:name => ""}
         response.should render_template(:edit)
         assigns(:question).should eq(question)
       end
     end
  end
  
end 