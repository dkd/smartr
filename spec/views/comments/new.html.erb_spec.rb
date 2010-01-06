require 'spec_helper'

describe "/comments/new.html.erb" do
  include CommentsHelper

  before(:each) do
    assigns[:comment] = stub_model(Comment,
      :new_record? => true,
      :body => "value for body",
      :user_id => 1,
      :commentable_id => 1,
      :commentable_type => "value for commentable_type"
    )
  end

  it "renders new comment form" do
    render

    response.should have_tag("form[action=?][method=post]", comments_path) do
      with_tag("textarea#comment_body[name=?]", "comment[body]")
      with_tag("input#comment_user_id[name=?]", "comment[user_id]")
      with_tag("input#comment_commentable_id[name=?]", "comment[commentable_id]")
      with_tag("input#comment_commentable_type[name=?]", "comment[commentable_type]")
    end
  end
end
