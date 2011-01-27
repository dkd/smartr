require "spec_helper"

describe CommentsController do
  include Devise::TestHelpers
  render_views
  let(:question){Factory.create :question2}

  context "An unauthorized User" do
    context " with Javascript enabled"
    describe "posts a comment" do
      it "should redirect to the question" do
        xhr :post, :create
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "edits a comment" do
      it "should redirect to the question" do
        xhr :post, :update, :id => 1, :commentable_type => "question", :commentable_id => question.id
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "tries to load the new comment form" do
      it "should redirect to the question" do
        xhr :get, :new, :commentable_type => "question", :commentable_id => question.id
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "tries to load the edit comment form" do
      it "should redirect to the question" do
        xhr :get, :edit, :id => 1
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
  end

  context "An authorized User" do
    before do
      sign_in question.user
    end
    context "with Javascript enabled" do
      
      describe "wants to post a comment" do
        it "should load the new comment form" do
          xhr :get, :new, :commentable_type => "question", :commentable_id => question.id
          response.should be_success
          response.should render_template("new")
        end
      end
      
      describe "posts a valid new comment" do
        it "should display the comment" do
          xhr :post, :create, :comment => {:commentable_type => "Question", :commentable_id => question.id, :body => "I am a valid comment! I can be saved!"}
          response.should be_success 
          response.should render_template("create")
        end
      end
      
      describe "posts an invalid new comment" do
        it "should display the new comment form" do
          xhr :post, :create, :comment => {:commentable_type => "Question", :commentable_id => question.id, :body => nil}
          response.should be_success
          response.should render_template("invalid_comment")
        end
      end
      
    end
  end
end
