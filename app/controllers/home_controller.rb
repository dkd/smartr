class HomeController < ApplicationController
  
  def index
    @questions = Question.latest
  end
  
end
