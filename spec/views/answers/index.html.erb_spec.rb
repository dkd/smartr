require 'spec_helper'

describe "/answers/index.html.erb" do
  include AnswersHelper

  before(:each) do
    assigns[:answers] = [
      stub_model(Answer,
        :body => "value for body",
        :question_id => 1,
        :user_id => 1
      ),
      stub_model(Answer,
        :body => "value for body",
        :question_id => 1,
        :user_id => 1
      )
    ]
  end

  it "renders a list of answers" do
    render
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
