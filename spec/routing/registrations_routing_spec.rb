require "spec_helper"

describe RegistrationsController do

  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/users/sign_up" }.should route_to( :controller => "registrations",
                                                    :action => "new" )
    end

    it "recognizes and generates #create" do
      { :post => "/users" }.should route_to( :controller => "registrations",
                                                     :action => "create" )
    end
    
    it "recognizes and generates #cancel" do
      { :get => "/users/cancel" }.should route_to( :controller => "registrations",
                                                   :action => "cancel" )
    end
    
    it "recognizes and generates #cancel" do
      { :get => "/users/cancel" }.should route_to( :controller => "registrations",
                                                   :action => "cancel" )
    end
    
    it "recognizes and generates #edit" do
      { :get => "/users/edit" }.should route_to( :controller => "registrations",
                                                 :action => "edit" )
    end
    it "recognizes and generates #update" do
      { :put => "/users" }.should route_to( :controller => "registrations",
                                            :action => "update" )
    end
    it "recognizes and generates #destroy" do
      { :delete => "/users" }.should route_to( :controller => "registrations",
                                            :action => "destroy" )
    end
  end
end