class ErrorsController < ApplicationController
  def routing
    render :status => 404, :layout => true
  end
end
