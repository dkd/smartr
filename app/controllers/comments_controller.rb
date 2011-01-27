class CommentsController < ApplicationController
  
  before_filter :require_user, :only => [:new, :edit, :create, :destroy, :update]

  def new
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      format.js { 
        render :update do |page|
          page["##{params[:commentable_type]}-comments-#{params[:commentable_id]} .comment-new"].hide
          page["##{params[:commentable_type]}-comments-#{params[:commentable_id]}"].append(
                                    render(:partial => "new", :locals => {:comment => @comment, 
                                                                          :commentable_type => params[:commentable_type], 
                                                                          :commentable_id => params[:commentable_id]
                                                                          }) )
        end
      }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page["comment-#{params[:id]}"].html(
                                    render(:partial => "new", :locals => {:comment => @comment, 
                                                                          :commentable_type => params[:commentable_type], 
                                                                          :commentable_id => params[:commentable_id]
                                                                          }) )
        end
      end
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      format.js { 
      if @comment.save
        @parent = @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
      else
        render "invalid_comment"
      end
     }
    end
  end

  # PUT /comments/1
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to(comments_url) }

    end
  end
end
