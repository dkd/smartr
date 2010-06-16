class Admin::QuestionsController < ApplicationController
  # GET /admin_questions
  # GET /admin_questions.xml
  def index
    @admin_questions = Admin::Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_questions }
    end
  end

  # GET /admin_questions/1
  # GET /admin_questions/1.xml
  def show
    @question = Admin::Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /admin_questions/new
  # GET /admin_questions/new.xml
  def new
    @question = Admin::Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /admin_questions/1/edit
  def edit
    @question = Admin::Question.find(params[:id])
  end

  # POST /admin_questions
  # POST /admin_questions.xml
  def create
    @question = Admin::Question.new(params[:question])

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Admin::Question was successfully created.'
        format.html { redirect_to(@question) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_questions/1
  # PUT /admin_questions/1.xml
  def update
    @question = Admin::Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Admin::Question was successfully updated.'
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_questions/1
  # DELETE /admin_questions/1.xml
  def destroy
    @question = Admin::Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(admin_questions_url) }
      format.xml  { head :ok }
    end
  end
end
