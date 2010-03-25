class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user#, :only => [:edit, :update]
  
  def index
    respond_to do |format|
      format.html{ @users = User.find(:all, :order => "reputation desc").paginate :page => params[:page], :per_page => 10}
      format.js {
        unless params[:q].blank?
          @users = User.find(:all, :conditions => ["login like ?","%#{params[:q]}%"], :order => "reputation desc").paginate :page => params[:page], :per_page => 10
        else
          @users = User.find(:all, :order => "reputation desc").paginate :page => params[:page], :per_page => 10
        end  
        
        render :partial => "list", :locals => {:users => @users}
        }
    end
  end
  
  def search
    index
  end
  
  def favourites
    @questions = Question.find(:all, :joins => :favourites, :conditions => ['favourites.user_id', params[:user_id]])
  end
  
  def who_is_online
    @users = User.logged_in
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
      render :action => :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user.count_view unless current_user == @user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(:id => current_user.id)
    else
      render :action => :edit
    end
  end
  
  
  protected
  
  def index_for_winner
     format.html{ @users = User.find(:all).paginate :page => params[:page], :per_page => 20}
      render :index
  end
  
  
  
end
