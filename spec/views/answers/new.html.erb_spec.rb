require 'spec_helper'

describe "/answers/new.html.erb" do
  include AnswersHelper

  before(:each) do
    assigns[:answer] = stub_model(Answer,
      :new_record? => true,
      :body => "value for body",
      :question_id => 1,
      :user_id => 1
    )
  end

  it "renders new answer form" do
    render

    response.should have_tag("form[action=?][method=post]", answers_path) do
      with_tag("textarea#answer_body[name=?]", "answer[body]")
      with_tag("input#answer_question_id[name=?]", "answer[question_id]")
      with_tag("input#answer_user_id[name=?]", "answer[user_id]")
    end
  end
end
