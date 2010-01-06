require 'spec_helper'

describe "/comments/index.html.erb" do
  include CommentsHelper

  before(:each) do
    assigns[:comments] = [
      stub_model(Comment,
        :body => "value for body",
        :user_id => 1,
        :commentable_id => 1,
        :commentable_type => "value for commentable_type"
      ),
      stub_model(Comment,
        :body => "value for body",
        :user_id => 1,
        :commentable_id => 1,
        :commentable_type => "value for commentable_type"
      )
    ]
  end

  it "renders a list of comments" do
    render
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for commentable_type".to_s, 2)
  end
end
