class TagsController < ApplicationController
  before_filter :require_user
  
  def index
    if params[:tag].present?
      @tags = Question.tagged_with("#{params[:tag]}%").tag_counts.collect{ |t| t if t.name.match /#{params[:tag]}/ }.delete_if{ |t| t==nil }
    else
      @tags = Question.tag_counts
    end
    respond_to do |format|
      format.html{}
      format.js{
        render :partial => "list"
      }
    end
  end

end