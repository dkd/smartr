class Api::V1::QuestionsController < ApplicationController
  respond_to :json
  def index
    @questions = Question.latest.paginate :page => params[:page], :per_page => 30
    render :json => @questions.to_json(:include => :user)
  end
end