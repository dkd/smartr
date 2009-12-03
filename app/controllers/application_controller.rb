# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :search_options
  
  protected
    
    def search_options
      @user_facet = nil
      if params[:search] && params[:search][:searchstring]
        @searchstring =  params[:search][:searchstring]
        @user_facet = params[:user_id] unless params[:user_id].nil?
      else
        @searchstring = ""
      end
      
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      
      respond_to do |format|
        format.html{
          unless current_user
            store_location
            flash[:notice] = "You must be logged in to access this page"
            redirect_to new_user_session_url
            false
          end
        }
        format.js{
          unless current_user  
            render :text => "alert('You must be logged in to perform this action');"
            false
          end
        }
      end
      
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
