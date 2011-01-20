class VotesController < ApplicationController
  before_filter :require_user
  #respond_format :js
  
  def update
    record = "#{params[:model]}".classify.constantize.find(params[:id])        
    if(record.user == @current_user)
      render "shared/message"
    else
      vote = Vote.find_or_create_by_voteable_type_and_voteable_id_and_user_id("#{params[:model]}".classify, params[:id], @current_user.id)
      
      render :update do |page|
        
        page["##{params[:dom_id]}"].html vote.cast(params[:direction])
        page[".user-#{vote.voteable.user.id}-reputation"].html(vote.voteable.user.reputation)
        page[".user-#{vote.voteable.user.id}-reputation"].effect('pulsate', :duration => 0.3)
        
        if params[:model] == "answer"
          page["##{params[:vote_box_id]}"].html render(:partial => "/answers/vote_box", :locals => {:answer => record})
        end
        if params[:model] == "question"
          page["##{params[:vote_box_id]}"].html render(:partial => "/questions/vote_box", :locals => {:question => record})
        end
      end
    end
  end
end
