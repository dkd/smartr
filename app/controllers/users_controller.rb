class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :is_admin?, :only => [:admin]

  def index
    @users = User.reputation.paginate :page => params[:page], :per_page => 10
  end

  def search
    if params[:q].present?
      @users = User.find(:all, :conditions => ["login like ?","%#{params[:q]}%"], :order => "reputation desc").paginate :page => params[:page], :per_page => 10
    else
      @users = User.find(:all, :order => "reputation desc").paginate :page => params[:page], :per_page => 10
    end
  end

  def who_is_online
    @users = User.online
  end


  def reputation
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user.count_view! unless current_user == @user
  end

end
