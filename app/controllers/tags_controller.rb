class TagsController < ApplicationController
  before_filter :require_user
  
  def index
    
    if params[:q].present?
      @tags = Question.tagged_with("#{params[:q]}%").tag_counts.collect{ |t| t if t.name.match /#{params[:q]}/ }.delete_if{ |t| t==nil }
    else
      @tags = Question.tag_counts
    end
    respond_to do |format|
      
      format.html{}
      
      format.js{
        render :partial => "list"
      }
      format.json{
        puts "Hallo"
        render :json, @tags.to_json
      }
    end
  end
  
  
  
end