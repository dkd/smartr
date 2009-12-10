require 'test_helper'

class FavouritesControllerTest < ActionController::TestCase
  
  test "add favourite" do
    Factory(:question)
    UserSession.create Factory.build(:user)
    xhr :post, :create, {:favourite => {:question_id => Factory(:question).id}}
  end
  
  
  
end
