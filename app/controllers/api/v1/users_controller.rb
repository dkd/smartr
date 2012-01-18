class Api::V1::UsersController < ApplicationController
  respond_to :json
  def index
     @users = User.latest.page(params[:page]).per(15)
     respond_with @users.to_json(:only => [:login])
   end
end
