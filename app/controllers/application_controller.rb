# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper_method :current_user_session, :current_user, :is_admin?
  filter_parameter_logging :password, :password_confirmation
  before_filter :search_options
  
  
  def rescue_action(exception)
     
     return super if Rails.env != "production"
     
     log_error(exception) if logger
     if exception
       render :text => "The page you requested, does not exist."
     end
   end
  
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
    
    # Returns the current user.
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

        format.xml{
         if current_user
           true
          else
            authenticate_or_request_with_http_basic do |username, password|
              username == "smartr" && password == "dingdongdiehexisttod"
            end
          end
        }

        format.json{
          true# if current_user
        }

        format.js{
          unless current_user  
            
            render :update do |page|
              page << "$.gritter.add({
              	title: 'Nothing',              	
              	text: 'You must be logged in order to perform this action.',
              	time: 5000
              });"
            end
            false
          end
        }
      end
      
    end
    
    def require_admin
      self.is_admin?
    end
    
    def is_admin?
      if current_user && current_user.is_admin?
       true
     else
       false
     end
    end
    
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
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
