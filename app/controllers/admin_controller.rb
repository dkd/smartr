class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @votes = Vote.all.page :page => params[:page], :per_page => 15
  end
end