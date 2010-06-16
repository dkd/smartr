class Api::V1::QuestionsController < ApplicationController
  
  def index
    @questions = Question.latest.paginate :page => params[:page], :per_page => 30
    
    respond_to do |format|
      format.json{
        render :json => @questions.to_json(:include => :user)
      }
    end
    
  end
    
end