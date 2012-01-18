class Api::V1::QuestionsController < ApplicationController
  respond_to :json
  def index
    @questions = Question.latest.page(params[:page]).per(30)
    respond_to do |format|
      format.json {
        render :json => { :items => @questions.map(&:as_json),
                          :count => @questions.size }

        }
    end
  end
end