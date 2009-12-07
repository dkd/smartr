class TagsController < ApplicationController

  def index
    if params[:tag].present?
      @tags = Question.tagged_with("#{params[:tag]}%").tag_counts
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