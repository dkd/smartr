class Admin::UsersController < ApplicationController
  # GET /admin_users
  # GET /admin_users.xml
  def index
    @admin_users = Admin::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_users }
    end
  end

  # GET /admin_users/1
  # GET /admin_users/1.xml
  def show
    @user = Admin::User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /admin_users/new
  # GET /admin_users/new.xml
  def new
    @user = Admin::User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /admin_users/1/edit
  def edit
    @user = Admin::User.find(params[:id])
  end

  # POST /admin_users
  # POST /admin_users.xml
  def create
    @user = Admin::User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Admin::User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_users/1
  # PUT /admin_users/1.xml
  def update
    @user = Admin::User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Admin::User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_users/1
  # DELETE /admin_users/1.xml
  def destroy
    @user = Admin::User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end
end
