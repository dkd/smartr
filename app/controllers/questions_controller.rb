class QuestionsController < ApplicationController
  
  before_filter :require_user, :only => [:edit, :create, :new, :update, :destroy, :update_for_toggle_acceptance]
  before_filter :check_ownership, :only => [:update, :destroy, :edit, :update_for_toggle_acceptance]
  respond_to :html, :js, :xml
  def index
      if (params[:tag].present?)
        @questions = Question.latest.list.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => 15
      else
        @questions = Question.latest.list.paginate :page => params[:page], :per_page => 15
      end
      respond_to do |format|
        format.xml
        format.html
      end
  end

  # GET /questions/1/friendly_id
  def show
    @question = Question.find(params[:id])
    @question.update_views if @question.present?
    @answer = Answer.new
    @answer.question = @question
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])
    @question.user = current_user
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        redirect_to question_url(@question.id, @question.friendly_id)
      else
        flash[:error] = 'Please fill in all requested fields!'
        render :action => "new"
      end
  end

  def update
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        redirect_to question_url(:id => @question.id, :friendly_id => @question.friendly_id)
      else
        render :action => "edit"
      end

  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to(questions_url)

  end

  def hot
    @questions = Question.hot.list.paginate :page => params[:page], :per_page => 15
    render :index_for_hot
  end
  
  def active
    @questions = Question.active.list.paginate :page => params[:page], :per_page => 15
    render :index_for_active
  end
  
  def unanswered
    @questions = Question.unanswered.list.paginate :page => params[:page], :per_page => 15
    render :index_for_unanswered
  end
  
  #def tagged
  #  @questions = Question.latest.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => 15
  #end
  
  def search
    @searchstring = params[:question][:searchstring]
    @questions = Sunspot.search(Question) do
      logger.info @searchstring
      fulltext params[:question][:searchstring] do
        highlight :name
        tie 0.1
      end
      with :user_id, params[:question][:user_id] unless params[:question][:user_id].blank?
      facet :user_id, :minimum_count => 2
      paginate(:page =>  params[:page], :per_page => 15)
    end
    respond_with(@questions) do |format|
      format.html
      format.js
    end
  end
  
  def update_for_toggle_acceptance
    @question = Question.find(params[:id])
    logger.info request.inspect
    respond_to do |format|
      format.js{
          @answer = Answer.find(params[:answer_id])
          if @answer.present?
            Reputation.toggle_acceptance(@question, @answer)
            @answer.reload
          end
      }
    end
  end
  
  protected
  
  def check_for_tag
    if (params[:tag].present?)
      @questions = @questions.tagged_with(params[:tag])
    else
      @questions
    end
  end

  def check_ownership
    @question = Question.find(params[:id])
    if @question.user != current_user
      flash[:error] = "You are not the owner of the question!"
      respond_to do |format|
        format.html { redirect_to question_url(:id => @question.id, :friendly_id => @question.friendly_id) }
      end
    end
  end
  
end
