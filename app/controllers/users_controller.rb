class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]

  def index
    @users = User.best.page params[:page]
  end

  def search
    if params[:q].present?
      @users = User.search(params[:q], params[:page])
    else
      @users = User.page(params[:page])
    end
    respond_to do |format|
      format.js {}
      format.html { render :index }
    end
    Rails.logger.info @users.inspect 
  end

  def who_is_online
    @users = User.online.page(params[:page])
  end

  def reputation
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user.count_view! unless current_user == @user
  end

end