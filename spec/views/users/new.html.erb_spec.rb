require 'spec_helper'

describe "users/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    asert_select "form", :action => users_path, :method => "post" do
    end
  end
end
