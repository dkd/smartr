require "spec_helper"

describe AnswersController do
  include Devise::TestHelpers
  let(:question) {FactoryGirl.create :question2}
  let(:user) {FactoryGirl.create :endless_user }
  render_views

  describe "unauthorized user" do

    describe "POST answer" do
      it "should redirect to the login page" do
        post :create, :question_id => question.id, :friendly_id => question.friendly_id
        response.should redirect_to :controller => "sessions", :action => "new"
      end
    end

    describe "PUT answer" do
      it "should redirect to the login page" do
        answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
        put :update, :question_id => question.id, :id => answer.id, :friendly_id => answer.question.friendly_id
        response.should redirect_to :controller => "sessions", :action => "new"
      end
    end

    describe "GET answer" do
      it "edit should redirect to the login page" do
        answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
        get :edit, :question_id => answer.question.id, :friendly_id => answer.question.friendly_id, :id => answer.id
        response.should redirect_to :controller => "sessions", :action => "new"
      end
    end

  end

  context "An authorized user" do
    before do
      sign_in user
    end

    context "with valid answer parameters" do

      describe "POST answer" do
        it "should redirect to the question of the answer" do
          answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
          post :create, :question_id => answer.question.id, :friendly_id => answer.question.friendly_id, :answer => {:body => Faker::Lorem.sentences(10).to_s}
          response.should redirect_to(:controller => "questions", :action => "show", :id => answer.question.id, :friendly_id => answer.question.friendly_id)
          assigns(:question).should eq(answer.question)
        end
      end

      describe "PUT answer" do
        it "should redirect to the question of the answer" do
          answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
          put :update, :question_id => answer.question.id, :friendly_id => answer.question.friendly_id, :id => answer.id, :answer => {:body => Faker::Lorem.sentences(10).to_s}
          response.should redirect_to(:controller => "questions", :action => "show", :id => answer.question.id, :friendly_id => answer.question.friendly_id)
          assigns(:question).should eq(answer.question) 
        end
      end

    end

    context "with invalid answer parameters" do

      let(:question) {FactoryGirl.create :question2}
      describe "POST answer" do
        it "should redirect to the edit answer page" do
          answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
          post :create, :question_id => answer.question.id, :friendly_id => answer.question.friendly_id, :answer => {:body => nil}
          response.should render_template(:new)
          assigns(:question).should eq(answer.question)
        end
      end

      describe "PUT answer" do
        it "should redirect to the edit answer page" do
          answer = FactoryGirl.create(:full_answer, :user => user, :question => question)
          put :update, :question_id => answer.question.id, :friendly_id => answer.question.friendly_id, :id => answer.id, :answer => {:body => nil}
          response.should render_template(:edit)
          assigns(:question).should eq(answer.question)
        end
      end
      
    end
    
  end
  
end