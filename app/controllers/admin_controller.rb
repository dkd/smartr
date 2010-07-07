class AdminController < ApplicationController
  before_filter :require_admin
  def index
    @votes = Vote.find(:all, :order => 'updated_at desc').paginate :page => params[:page], :per_page => 15
  end
end