class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :load_user, :only => [:show, :reputation, :questions, :answers]
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
    @users = User.online.paginate(:page => params[:page])
  end

  def reputation

  end

  def show
    @user.count_view! unless current_user == @user
  end

  def questions
    @questions = @user.questions.paginate(:page => params[:page])
  end

  def answers
    @questions = Question.joins(:answers).where("answers.user_id = ?", @user.id).group("questions.id").paginate(:page => params[:page])
  end

  protected

  def load_user
    @user = User.find(params[:id])
  end

end