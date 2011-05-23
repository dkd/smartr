class AdminController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @votes = Vote.all.paginate :page => params[:page], :per_page => 15
  end
end