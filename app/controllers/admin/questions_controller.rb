class Admin::QuestionsController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html, :js
  def index
    @admin_questions = Admin::Question.all
  end

  def show
    @question = Admin::Question.find(params[:id])
  end

  def update
    @question = Admin::Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = 'Admin::Question was successfully updated.'
      redirect_to(@question)

    else
      render :action => "edit"
    end
  end

  def destroy
    @question = Admin::Question.find(params[:id])
    @question.destroy
    redirect_to(admin_questions_url)
  end
end
