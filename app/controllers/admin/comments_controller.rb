class Admin::CommentsController < ApplicationController
  before_filter :require_admin
  respond_to :html, :js

  # GET /admin_comments
  def index
    @admin_comments = Admin::Comment.all
  end

  # GET /admin_comments/1
  def show
    @comment = Admin::Comment.find(params[:id])
  end

  # GET /admin_comments/new
  def new
    @comment = Admin::Comment.new
  end

  # GET /admin_comments/1/edit
  def edit
    @comment = Admin::Comment.find(params[:id])
  end

  # POST /admin_comments
  def create
    @comment = Admin::Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Admin::Comment was successfully created.'
      redirect_to(@comment)
    else
      render :new
    end
  end

  # PUT /admin_comments/1
  def update
    @comment = Admin::Comment.find(params[:id])
   if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Admin::Comment was successfully updated.'
      redirect_to(@comment)
    else
      render :edit
    end
  end

  # DELETE /admin_comments/1
  def destroy
    @comment = Admin::Comment.find(params[:id])
    @comment.destroy
    redirect_to(admin_comments_url)
  end
end
