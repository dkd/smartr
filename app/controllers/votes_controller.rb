class VotesController < ApplicationController
  before_filter :require_user
  before_filter :check_params
  respond_to :js
  
  def update
    @record = "#{params[:model]}".classify.constantize.find(params[:id])        
    
    if(@record.user == @current_user)
      render "shared/message"
    else
      @vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("#{params[:model]}".classify, params[:id], current_user.id)
      @dom_id = params[:dom_id]
      @vote_count = @vote.cast(params[:direction])
      @vote_box_id = params[:vote_box_id]
      @model = params[:model]
    end
  end
  
  private
  
  def check_params
    render "shared/message" unless %w(answer question).include?(params[:model])
  end
end
