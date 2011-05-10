require "spec_helper"

describe RegistrationsController do

  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/users/sign_in" }.should route_to( :controller => "sessions",
                                                    :action => "new" )
    end
    it "recognizes and generates #create" do
      { :post => "/users/sign_in" }.should route_to( :controller => "sessions",
                                                    :action => "create" )
    end
    it "recognizes and generates #delete" do
      { :get => "/users/sign_out" }.should route_to( :controller => "sessions",
                                                    :action => "destroy" )
    end
  end
end