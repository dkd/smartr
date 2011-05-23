class Admin::AnswersController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html
  # GET /admin_answers
  def index
    @admin_answers = Admin::Answer.all
  end

  # GET /admin_answers/1
  def show
    @answer = Admin::Answer.find(params[:id])
  end

  # GET /admin_answers/new
  def new
    @answer = Admin::Answer.new
  end

  # GET /admin_answers/1/edit
  def edit
    @answer = Admin::Answer.find(params[:id])
  end

  # POST /admin_answers
  def create
    @answer = Admin::Answer.new(params[:answer])
    if @answer.save
      flash[:notice] = 'Admin::Answer was successfully created.'
      redirect_to(@answer)
    else
      render :new
    end
  end

  # PUT /admin_answers/1
  def update
    @answer = Admin::Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
      flash[:notice] = 'Admin::Answer was successfully updated.'
      redirect_to(@answer)
    else
      render :edit
    end
  end

  # DELETE /admin_answers/1
  def destroy
    @answer = Admin::Answer.find(params[:id])
    @answer.destroy
    redirect_to(admin_answers_url)
  end
end
