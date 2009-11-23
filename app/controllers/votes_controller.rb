class VotesController < ApplicationController
  before_filter :require_user
  
  def update
    respond_to do |format|
      format.js{
        record = "#{params[:model]}".classify.constantize.find(params[:id])        
        if(record.user == @current_user)
          render :text => "alert('You cannot vote on yourself!')"
        else
          vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("#{params[:model]}".classify, params[:id], @current_user.id)
          render :update do |page|
            page[params[:dom_id]].replace_html vote.cast(params[:direction])
            if params[:model] == "answer"
            page[params[:vote_box_id]].replace_html render(:partial => "/answers/vote_box", :locals => {:answer => record})
            end
          end
        end
        
      }
    end
  end
end
