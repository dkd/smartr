class VotesController < ApplicationController
  before_filter :require_user
  before_filter :check_params
  before_filter :check_owner
  respond_to :js
  
  def create
    @vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("#{params[:model]}".classify, params[:id], current_user.id)
    if @vote.update_attributes(:value => params[:value]) == false
     render "shared/message"
    end
    #@dom_id = params[:dom_id]
    #@vote_count = @vote.set(params[:direction])
    #@vote_box_id = params[:vote_box_id]
    #@model = params[:model]
  end
  
  private
  
  def check_params
    render "shared/message" unless %w(answer question comment).include?(params[:model])
  end
  
  def check_owner
    @record = "#{params[:model]}".classify.constantize.find(params[:id])
    if(@record.user == current_user) then
      render "shared/message"
      false
    else
      true
    end
  end
  
end
