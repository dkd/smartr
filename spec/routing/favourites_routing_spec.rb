require "spec_helper"

describe FavouritesController do

  describe "routing" do
    it "recognizes and generates #toggle" do
      { :post => "/favourites/1/toggle" }.should route_to(:controller => "favourites", :action => "toggle", :id => "1")
    end
    it "recognizes and generates #index" do
      { :get => "/users/1/favourites" }.should route_to(:controller => "favourites", :action => "index", :user_id => "1")
    end
  end

end