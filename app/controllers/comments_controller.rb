class CommentsController < ApplicationController
  
  before_filter :require_user, :only => [:new, :edit, :create, :update]
  before_filter :require_owner, :only => [:edit, :update]
  respond_to :js
  
  def new
    @comment = Comment.new(params[:comment])
  end

  # GET /comments/1/edit
  def edit
    
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
      if @comment.save
        @parent = @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
      else
        render "invalid_comment"
      end
  end

  # PUT /comments/1
  def update
    
    if @comment.update_attributes(params[:comment])
    else
      render "invalid_comment"
    end
  end

  protected
  
  def require_owner
    @comment = Comment.find(params[:id])
    if @comment.present? && @comment.user == current_user
      true
    else
      render :partial => "shared/not_authorized"
    end
  end
  
end
