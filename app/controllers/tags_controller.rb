class TagsController < ApplicationController
  
  def index
    # Refactor
    # select count(*), T.name from tags as T, taggings as G 
    # WHERE g.tag_id = T.id
    # GROUP by T.id
    # ORDER BY
    # count(*) DESC
    
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