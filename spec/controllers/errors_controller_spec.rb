require "spec_helper"

describe ErrorsController do
  include Devise::TestHelpers
  it "returns the error page" do
    get :routing
    response.code.should eq("404")
    response.should render_template("routing")
  end

end