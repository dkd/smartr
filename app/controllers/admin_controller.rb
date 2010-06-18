class AdminController < ApplicationController
  before_filter :require_admin
  def index
    @votes = Vote.find(:all,  :limit => 10, :order => 'updated_at desc')
  end
end