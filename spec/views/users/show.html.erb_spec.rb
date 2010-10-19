require 'spec_helper'

describe "users/show.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User, :login => 'hanswurst',
                                           :email => "hans@wurst.com",
                                           :password => "iamaverygoodpassword",
                                           :password_confirmation => "iamaverygoodpassword"))
  end

  it "renders attributes in <p>" do
    render
  end
end
