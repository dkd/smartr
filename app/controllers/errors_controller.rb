class ErrorsController < ApplicationController
  def routing
    render :status => 404, :layout => "application", :text => "something fishy is happening right now!"
  end
end
