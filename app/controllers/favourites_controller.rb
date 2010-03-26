class FavouritesController < ApplicationController
  
  before_filter :require_user
  
  helper UsersHelper
  
  def index
    @user = User.find params[:user_id]
    @questions = Question.find(:all, :joins => :favourites, :conditions => ['favourites.user_id', params[:user_id]])
    render "/users/favourites", :layout => true
  end
  
  def toggle
    @favourite = Favourite.find_by_user_id_and_question_id(@current_user.id, params[:favourite][:question_id])
    
    respond_to do |format|
      format.js { 
        render :update do |page|
          
          if @favourite.blank?
            page << "$('#favourite-question-#{params[:favourite][:question_id]}').attr('class', 'favourite-saved')"
            page << "$.gritter.add({
                        	title: 'Favourite saved',              	
                        	text: 'You successfully saved this question!',
                        	time: 5000,
                        	class_name: 'gritter-info'
                        });"
            @favourite = Favourite.new(params[:favourite])
            @favourite.user = @current_user
            @favourite.save
          else
            page << "$('#favourite-question-#{params[:favourite][:question_id]}').attr('class', 'favourite')"
            page << "$.gritter.add({
                        	title: 'Favourite deleted',              	
                        	text: 'You successfully deleted this question!',
                        	time: 5000,
                        	class_name: 'gritter-info'
                        });"
            @favourite.destroy
            end
          page
        end
        }
    end    
  end
  
end
