class ApplicationController < ActionController::Base

  helper_method :current_user_session, :current_user, :is_admin?

  before_filter :set_last_request_at#, :store_location
  before_filter :set_order
  before_filter :set_locale

  rescue_from Errno::ECONNREFUSED, :with => :render_search_down

  protected

  def set_locale
    I18n.locale = params[:locale]
  end

  def set_order
    session[:comments_order] = "latest" if session[:comments_order].blank?
    session[:comments_order] = params[:comments_order] if Comment::ORDER.include?(params[:comments_order])
  end

  def after_sign_in_path_for(resource)
      stored_location_for(:user) || root_path
  end

  def authenticate_admin!
    if user_signed_in? && current_user.is_admin?
      true
    else
      flash[:notice] = "You must be logged in as admin to access this page"
      redirect_to root_url
      false
    end
  end

  def render_search_down
    respond_to do |type|
      type.html { render "errors/search_down", status: "500 Internal Server Error" }
      type.all  { render nothing: true, status: "500 Internal Server Error" }
    end
  end

  def is_admin?
    if user_signed_in? && current_user.is_admin?
     true
   else
     false
   end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  private

  def set_last_request_at
    current_user.update_attribute(:last_request_at, Time.now) if current_user.present?
  end
end