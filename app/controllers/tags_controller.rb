class TagsController < ApplicationController
  
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
        render :json => @tags.map { |tag| tag.name}.to_json
      }
    end
  end
  
end