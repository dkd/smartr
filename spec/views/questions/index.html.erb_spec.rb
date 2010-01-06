require 'spec_helper'

describe "/questions/index.html.erb" do
  include QuestionsHelper

  before(:each) do
    assigns[:questions] = [
      stub_model(Question,
        :name => "value for name",
        :body => "value for body",
        :user_id => 1,
        :views => 1
      ),
      stub_model(Question,
        :name => "value for name",
        :body => "value for body",
        :user_id => 1,
        :views => 1
      )
    ]
  end

  it "renders a list of questions" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
