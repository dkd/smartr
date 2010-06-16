class Admin::AnswersController < ApplicationController
  before_filter :require_admin
  
  # GET /admin_answers
  # GET /admin_answers.xml
  def index
    @admin_answers = Admin::Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_answers }
    end
  end

  # GET /admin_answers/1
  # GET /admin_answers/1.xml
  def show
    @answer = Admin::Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /admin_answers/new
  # GET /admin_answers/new.xml
  def new
    @answer = Admin::Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /admin_answers/1/edit
  def edit
    @answer = Admin::Answer.find(params[:id])
  end

  # POST /admin_answers
  # POST /admin_answers.xml
  def create
    @answer = Admin::Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Admin::Answer was successfully created.'
        format.html { redirect_to(@answer) }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_answers/1
  # PUT /admin_answers/1.xml
  def update
    @answer = Admin::Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Admin::Answer was successfully updated.'
        format.html { redirect_to(@answer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_answers/1
  # DELETE /admin_answers/1.xml
  def destroy
    @answer = Admin::Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(admin_answers_url) }
      format.xml  { head :ok }
    end
  end
end
