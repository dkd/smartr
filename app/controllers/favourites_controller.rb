class FavouritesController < ApplicationController
  respond_to :js, :html
  helper UsersHelper
  before_filter :authenticate_user!, :only => [:toggle]
  
  def index
    @user = User.find params[:user_id]
    @questions = @user.favourite_questions.paginate :page => params[:page], :per_page => 25
    render "/users/favourites", :layout => true
  end
  
  def toggle
    @favourite = Favourite.find_by_user_id_and_question_id(current_user.id, params[:id])
    @question_id = params[:id]
    respond_to do |format|
      format.js {
        if @favourite.blank?
          @message = "You successfully saved this question!"
          @class = "favourite-saved"
          @favourite = Favourite.new({:question_id => @question_id})
          @favourite.user = current_user
          @favourite.save
        else
          @message = "You successfully deleted this question!"
          @class = "favourite"
          @favourite.destroy
        end
      }
    end    
  end
  
end
