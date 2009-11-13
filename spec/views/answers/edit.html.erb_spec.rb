require 'spec_helper'

describe "/answers/edit.html.erb" do
  include AnswersHelper

  before(:each) do
    assigns[:answer] = @answer = stub_model(Answer,
      :new_record? => false,
      :body => "value for body",
      :question_id => 1,
      :user_id => 1
    )
  end

  it "renders the edit answer form" do
    render

    response.should have_tag("form[action=#{answer_path(@answer)}][method=post]") do
      with_tag('textarea#answer_body[name=?]', "answer[body]")
      with_tag('input#answer_question_id[name=?]', "answer[question_id]")
      with_tag('input#answer_user_id[name=?]', "answer[user_id]")
    end
  end
end
