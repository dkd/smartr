require "spec_helper"

describe VotesController do
  include Devise::TestHelpers
 
  describe "As a user who is" do

    context "not logged in" do
      describe "he votes on a question" do
        it "and fails" do
          xhr :post, :create, :id => 1000
          response.should render_template("shared/not_authorized")
        end 
      end
    end
    
    
    
    context "logged in" do
      let(:user2) {Factory.create :user2}
      before do
        sign_in user2
      end
      
      describe "and is the owner of the question" do
        let(:question) {Factory.create(:question2, :user => user2)}
        it "will fail" do
           xhr :post, :create, :model => "question",
                               :id => question.id
           response.should render_template("shared/message")
        end
      end
      
      describe "and is the owner of the question" do
        let(:answer) { Factory(:endless_answer, :question => Factory(:question2), :user => user2) }
        it "will fail" do
          xhr :post, :create, :model => "answer",
                              :id => answer.id
          response.should render_template("shared/message")
        end
      end
       
      describe "and votes up a question" do
        let(:question) { Factory.create :question2 }
        it "will render an updated votebox" do
          xhr :post, :create, :model => "question",
                              :direction => "up",
                              :dom_id => "votes-question-#{question.id}",
                              :vote_box_id => "vote-box-#{question.id}",
                              :id => question.id
          response.should be_successful
          response.should render_template(:create)
          assigns(:dom_id).should == "votes-question-#{question.id}"
          assigns(:vote_box_id).should == "vote-box-#{question.id}"
          assigns(:model).should == "question"
        end
      end
      
      describe "and votes down a question" do
        let(:question) { Factory.create :question2 }
        it "will render an updated votebox" do
          xhr :post, :create, :model => "question",
                              :direction => "down",
                              :dom_id => "votes-question-#{question.id}",
                              :vote_box_id => "vote-box-#{question.id}",
                              :id => question.id
          response.should be_successful
          response.should render_template(:create)
          assigns(:dom_id).should == "votes-question-#{question.id}"
          assigns(:vote_box_id).should == "vote-box-#{question.id}"
          assigns(:model).should == "question"
        end
      end
      
      describe "and votes up an answer" do
        let(:answer) { Factory(:endless_answer, :question => Factory(:question2)) }
        it "will render an updated votebox" do
          xhr :post, :create, :model => "answer",
                              :direction => "up",
                              :dom_id => "votes-answer-#{answer.id}",
                              :vote_box_id => "vote-box-#{answer.id}",
                              :id => answer.id
          response.should be_successful
          response.should render_template(:create)
          assigns(:dom_id).should == "votes-answer-#{answer.id}"
          assigns(:vote_box_id).should == "vote-box-#{answer.id}"
          assigns(:model).should == "answer"
        end
      end
      
      describe "and votes down an answer" do
        let(:answer) { Factory(:endless_answer, :question => Factory(:question2)) }
        it "will render an updated votebox" do
          xhr :post, :create, :model => "answer",
                              :direction => "down",
                              :dom_id => "votes-answer-#{answer.id}",
                              :vote_box_id => "vote-box-#{answer.id}",
                              :id => answer.id
          response.should be_successful
          response.should render_template(:create)
          assigns(:dom_id).should == "votes-answer-#{answer.id}"
          assigns(:vote_box_id).should == "vote-box-#{answer.id}"
          assigns(:model).should == "answer"
        end
      end

    end

  end
end