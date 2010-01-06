require 'spec_helper'

describe "/comments/show.html.erb" do
  include CommentsHelper
  before(:each) do
    assigns[:comment] = @comment = stub_model(Comment,
      :body => "value for body",
      :user_id => 1,
      :commentable_id => 1,
      :commentable_type => "value for commentable_type"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ body/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ commentable_type/)
  end
end
