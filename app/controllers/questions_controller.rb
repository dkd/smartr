class QuestionsController < ApplicationController
  
  before_filter :require_user, :only => [:edit, :new, :update, :destroy]
  before_filter :is_owner, :only => [:update, :destroy, :edit]
  
  def index
    
    if(params[:tag])
      index_for_tag
    else
      @questions = Question.latest
    end
    
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    @question.update_views if @question.present?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(@question) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])
    
    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => (params[:question][:answers_attributes]) ? "show" : "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
  
  def index_for_tag
    @questions = Question.latest.tagged_with(params[:tag])
  end
  
  def is_owner
    @question = Question.find(params[:id])
    if @question.user != current_user
      #flash[:error] = "You are not the owner of the question!"
      #redirect_to(questions_url)
    end
  end
  
end
