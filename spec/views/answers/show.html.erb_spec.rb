require 'spec_helper'

describe "/answers/show.html.erb" do
  include AnswersHelper
  before(:each) do
    assigns[:answer] = @answer = stub_model(Answer,
      :body => "value for body",
      :question_id => 1,
      :user_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ body/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
