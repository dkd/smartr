# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper_method :current_user_session, :current_user, :is_admin?
  before_filter :search_options
  before_filter :set_last_request_at, :store_location
  
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
            render "shared/not_authorized"
          end
        }
      end
    end
    
    def require_admin
      if current_user && current_user.is_admin?
       true
     else
       flash[:notice] = "You must be logged in as admin to access this page"
       redirect_to root_url
     end
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
