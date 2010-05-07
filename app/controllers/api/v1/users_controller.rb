class Api::V1::UsersController < ApplicationController
  
  def index
     @users = User.latest.paginate :page => params[:page], :per_page => 15

     respond_to do |format|
       format.json{
         render :json => @users.to_json(:methods => :image_url)
       }
     end

   end
  
end
