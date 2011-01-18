require "spec_helper"

describe AnswersController do
  include Devise::TestHelpers
  let(:answer) {Factory.create :full_answer}
  render_views
  
  describe "unauthorized user" do
    
    describe "POST answer" do
      it "should redirect to the login page" do
        post :create, :question_id => answer.question.id
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
    describe "PUT answer" do
      it "should redirect to the login page" do
        put :update, :question_id => answer.question.id, :id => answer.id
        response.should redirect_to :controller => "devise/sessions", :action => "new"
      end
    end
    
  end
  
  describe "authorized user" do
    before do
      sign_in answer.user
    end
    
    describe "POST answer" do
      it "should redirect to the question of the answer" do
        post :create, :question_id => answer.question.id, :answer => {:body => Faker::Lorem.sentences(10).to_s}
        response.should redirect_to(:controller => "questions", :action => "show", :id => answer.question.id, :friendly_id => answer.question.friendly_id)
        assigns(:question).should eq(answer.question)
      end
    end
    
    describe "PUT answer" do
      
    end
    
  end
  
end