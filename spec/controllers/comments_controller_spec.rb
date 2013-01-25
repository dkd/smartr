require "spec_helper"

describe CommentsController do
  include Devise::TestHelpers
  render_views
  let(:question) { FactoryGirl.create :question2 }

  context "An unauthorized User" do
    context " with Javascript enabled" do

      describe "comment order" do
        before do
          question.comments << FactoryGirl.build(:comment, :user => FactoryGirl.create(:endless_user))
          question.comments << FactoryGirl.build(:comment, :user => FactoryGirl.create(:endless_user))
        end
        it "orders by date" do
          xhr :get, :index, :comments_order => "latest", :id => question.id, :model => "Question"
          response.should render_template("index")
        end
        it "orders by reputation" do
          xhr :get, :index, :comments_order => "reputation", :id => question.id, :model => "Question"
          response.should render_template("index")
        end
      end

      describe "posts a comment" do
        it "should redirect to the question" do
          xhr :post, :create
          response.code.should == "401"
        end
      end
      describe "edits a comment" do
        it "should redirect to the question" do
          xhr :post, :update, :id => 1, :commentable_type => "question", :commentable_id => question.id
          response.code.should == "401"
        end
      end
      describe "tries to load the new comment form" do
        it "should redirect to the question" do
          xhr :get, :new, :commentable_type => "question", :commentable_id => question.id
          response.code.should == "401"
        end
      end
      describe "tries to load the edit comment form" do
        it "should redirect to the question" do
          xhr :get, :edit, :id => 1
          response.code.should == "401"
        end
      end
    end
  end

  context "An authorized User" do
    before do
      sign_in question.user
    end
    context "with Javascript enabled" do
      
      describe "wants to post a comment" do
        it "loads the new comment form" do
          xhr :get, :new, :commentable_type => "question", :commentable_id => question.id
          response.should be_success
          response.should render_template("new")
        end
      end
      
      describe "posts a valid new comment" do
        it "displays the comment" do
          xhr :post, :create, :comment => {:commentable_type => "Question", :commentable_id => question.id, :body => "I am a valid comment! I can be saved!"}
          response.should be_success 
          response.should render_template("create")
        end
      end
      
      describe "posts an invalid new comment" do
        it "displays the new comment form" do
          xhr :post, :create, :comment => {:commentable_type => "Question", :commentable_id => question.id, :body => nil}
          response.should be_success
          response.should render_template("invalid_comment")
        end
      end
      
      describe "edits his comment" do
          let(:comment) {comment = question.comments.new
          comment.user = question.user
          comment.body = Faker::Lorem.sentence(5)
          comment.save
          comment
          }
        it "loads the edit form" do
          xhr :get, :edit, :id => comment.id
          response.should be_success
          response.should render_template("edit")
        end
        it "saves the comment" do
          xhr :put, :update, :id => comment.id, :comment => {:body => Faker::Lorem.sentence(6)}
          response.should be_success
          response.should render_template("update")
        end
      end
      
    end
  end
end
