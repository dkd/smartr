# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# encoding: UTF-8
class ApplicationController < ActionController::Base
  has_mobile_fu
  helper_method :current_user_session, :current_user, :is_admin?
  before_filter :search_options
  before_filter :set_last_request_at, :store_location
  before_filter :set_order
  before_filter :set_locale
  
  def rescue_action(exception)
     
     return super if Rails.env != "production"
     
     log_error(exception) if logger
     if exception
       render :text => "The page you requested, does not exist."
     end
   end

  protected
    
    def set_locale
      I18n.locale = params[:locale]
    end
    
    def set_order 
      session[:comments_order] = "latest" if session[:comments_order].blank?
      session[:comments_order] = params[:comments_order] if Comment::ORDER.include?(params[:comments_order])
    end
    
    def search_options
      @user_facet = nil
      if params[:search] && params[:search][:searchstring]
        @searchstring =  params[:search][:searchstring]
        @user_facet = params[:user_id] unless params[:user_id].nil?
      else
        @searchstring = ""
      end
    end
    
    def require_user
      if user_signed_in?
        true
      else
        respond_to do |format|
          format.html{
            flash[:notice] = "You must be logged in to access this page"
            redirect_to new_user_session_url
          }
          format.xml{
              authenticate_or_request_with_http_basic do |username, password|
                username == "smartr" && password == "dingdongdiehexisttod"
            end
          }
          format.js{ render "shared/not_authorized" }
        end
        false
      end
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
    
    def is_admin?
      if user_signed_in? && current_user.is_admin?
       true
     else
       false
     end
    end

    def require_no_user
      if user_signed_in?
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    
    private
    
    def set_last_request_at 
      current_user.update_attribute(:last_request_at, Time.now) if current_user.present? 
    end
end
