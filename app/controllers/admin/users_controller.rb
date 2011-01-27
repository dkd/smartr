class Admin::UsersController < ApplicationController
  # GET /admin_users

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb

    end
  end

  # GET /admin_users/1

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb

    end
  end

  # GET /admin_users/new

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb

    end
  end

  # GET /admin_users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /admin_users
  # POST /admin_users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Admin::User was successfully created.'
        format.html { redirect_to(@user) }

      else
        format.html { render :action => "new" }

      end
    end
  end

  # PUT /admin_users/1

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Admin::User was successfully updated.'
        format.html { redirect_to(@user) }

      else
        format.html { render :action => "edit" }

      end
    end
  end

  # DELETE /admin_users/1

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
    end
  end
end
