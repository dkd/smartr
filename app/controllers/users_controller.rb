class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]
  before_filter :is_admin?, :only => [:admin]
  
  def index
    @users = User.find(:all, :order => "reputation desc").paginate :page => params[:page], :per_page => 10
  end

  def search
    unless params[:q].blank?
      @users = User.find(:all, :conditions => ["login like ?","%#{params[:q]}%"], :order => "reputation desc").paginate :page => params[:page], :per_page => 10
    else
      @users = User.find(:all, :order => "reputation desc").paginate :page => params[:page], :per_page => 10
    end
  end

  def who_is_online
    @users = User.online
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to user_path(:id => @user.id)
    else
      flash[:error] = "Please fill out the required fields!"
      render :action => :new
    end
  end
  
  def reputation
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @user.count_view unless current_user == @user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(:id => current_user.id)
    else
      render :action => :edit
    end
  end

end
