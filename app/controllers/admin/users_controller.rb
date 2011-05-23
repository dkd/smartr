class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!

  # GET /admin_users
  def index
    @users = User.all
  end

  # GET /admin_users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /admin_users/new
  def new
    @user = User.new
  end

  # GET /admin_users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /admin_users
  def create
    @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'Admin::User was successfully created.'
          redirect_to(admin_user_url(@user))
      else
        render :new
      end
  end

  # PUT /admin_users/1
  def update
    @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Admin::User was successfully updated.'
        redirect_to(admin_user_url(@user))
      else
        render :edit
      end
  end

  # DELETE /admin_users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(admin_users_url)
  end

end