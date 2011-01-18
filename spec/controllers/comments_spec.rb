require "spec_helper"

describe CommentsController do
  include Devise::TestHelpers
  let(:question){Factory.create :question2}
  
  context "Javascript enabled" do
    describe "an unauthorized user posts a comment" do
      it "should redirect to the question" do
        xhr :post, :create
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "an unauthorized user edits a comment" do
      it "should redirect to the question" do
        xhr :post, :update, :id => 1, :commentable_type => "question", :commentable_id => question.id
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "an unauthorized tries to load the new comment form" do
      it "should redirect to the question" do
        xhr :get, :new, :commentable_type => "question", :commentable_id => question.id
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
    describe "an unauthorized tries to load the edit comment form" do
      it "should redirect to the question" do
        xhr :get, :edit, :id => 1
        response.should be_success
        response.should render_template("not_authorized")
      end
    end
  end
end