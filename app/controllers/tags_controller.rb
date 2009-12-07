class TagsController < ApplicationController

  def index
    if params[:tag].present?
      @tags = Tag.find(:all, :conditions => ["name LIKE ?", "#{params[:tag]}%"])
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