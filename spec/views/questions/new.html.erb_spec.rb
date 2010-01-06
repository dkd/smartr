require 'spec_helper'

describe "/questions/new.html.erb" do
  include QuestionsHelper

  before(:each) do
    assigns[:question] = stub_model(Question,
      :new_record? => true,
      :name => "value for name",
      :body => "value for body",
      :user_id => 1,
      :views => 1
    )
  end

  it "renders new question form" do
    render

    response.should have_tag("form[action=?][method=post]", questions_path) do
      with_tag("input#question_name[name=?]", "question[name]")
      with_tag("textarea#question_body[name=?]", "question[body]")
      with_tag("input#question_user_id[name=?]", "question[user_id]")
      with_tag("input#question_views[name=?]", "question[views]")
    end
  end
end
