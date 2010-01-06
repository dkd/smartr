class FavouritesController < ApplicationController
  before_filter :require_user
  before_filter :is_owner
  
  def create
    @favourite = Favourite.new(params[:favourite])
    @favourite.user = @current_user
    if @favourite.save
      respond_to do |wants|
        wants.js { 
          render :text => "alert('saved')" 
          }
      end
    end
  end
  
  def destroy
    @favourite = Favourite.find_by_user_id_and_question_id(@current_user.id, params[:question_id])
    if @favourite.delete
      respond_to do |wants|
        wants.js { 
          render :text => "alert('deleted')"  
          }
      end
    end
  end
  
  
  private 
  
  def is_owner
    true
  end
        
end
