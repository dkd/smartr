class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_params
  respond_to :js

  def create
    @vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("#{params[:model]}".classify, params[:id], current_user.id)
    if @vote.update_attributes(:value => params[:value]) == false
      render "shared/message"
    end
  end

  private

  def check_params
    render "shared/message" unless %w(answer question comment).include?(params[:model])
  end

end