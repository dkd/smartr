class CommentsController < ApplicationController
  
  before_filter :require_user, :only => [:new, :edit, :create, :destroy, :update]
  
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

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
    @comment.user = @current_user
    respond_to do |format|
      if @comment.save
        format.js { 
          render :update do |page|
            parent = @comment.commentable_type.classify.constantize.find(@comment.commentable_id)
            page["#{@comment.commentable_type}-comments-#{@comment.commentable_id}"].replace_html(render(:partial => "list", 
                                                                                                         :locals => {
                 :comments => parent.comments,
                 :parent => parent
                 }
                 ))
          end
        }
      else
        format.js {
          render :update do |page|
            page << "$.gritter.add({
            	title: 'Validation failed',              	
            	text: 'You must enter something in order to perform this action.',
            	time: 5000,
            	class_name: 'gritter-error'
            });"
          end
        }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
