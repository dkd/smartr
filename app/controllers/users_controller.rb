class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]

  def index
    @users = User.best.page params[:page]
  end

  def search
    if params[:q].present?
      @users = User.search(params[:q])
    else
      @users = User.page params[:page], :per_page => 10
    end
    respond_to do |format|
      format.js {}
      format.html { render :index }
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
