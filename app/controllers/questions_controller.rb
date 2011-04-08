class QuestionsController < ApplicationController
  
  before_filter :require_user, :only => [:edit, :create, :new, :update, :destroy, :update_for_toggle_acceptance]
  before_filter :check_ownership, :only => [:update, :destroy, :edit, :update_for_toggle_acceptance]
  respond_to :html, :js, :xml, :json
  
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
    @related_questions = @question.find_related_tags.limit(10)
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
    @edit = @question.edits.new
    @related_questions = @question.find_related_tags.limit(10)
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
    @related_questions = @question.find_related_tags.limit(10)
    params[:question][:edits_attributes][:"0"][:user_id] = {}
    params[:question][:edits_attributes][:"0"][:user_id] = current_user.id
    
    if @question.update_attributes(params[:question])
      flash[:notice] = 'Question was successfully updated.'
      redirect_to question_url(:id => @question.id, :friendly_id => @question.friendly_id)
    else
      flash[:error] = 'Please fill in all requested fields!'
      @edit = @question.edits.last
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
    if params[:q].present?
      params[:question] = {}
      params[:question][:searchstring] = params[:q]
    end
    @searchstring = params[:question][:searchstring]
    @questions = Sunspot.search(Question) do
      fulltext params[:question][:searchstring] do
        highlight :name
        tie 0.1
      end
      
      if params[:question].present? && params[:question][:user_id].present?
         with(:user_id, params[:question][:user_id].to_i) 
      end
      
      if params[:question].present? && params[:question][:question_state].present?
        with(:question_state, question_state)
      end
      
      facet :user_id, :minimum_count => 2
      facet :question_state, :minimum_count => 2
      facet :created_at do
        row("last 7 days") do
          with(:created_at).greater_than(Time.now - 7.day)
        end
        row("last month") do
          with(:created_at).greater_than(Time.now - 31.day)
        end
        row("last 3 months") do
          with(:created_at).greater_than(Time.now - 3.month)
        end
        row("last 6 months") do
          with(:created_at).greater_than(Time.now - 6.month)
        end
        row("last 12 months") do
          with(:created_at).greater_than(Time.now - 12.month)
        end
      end
      
      if params[:question].present? && params[:question][:created_at].present?
        date_range = case params[:question][:created_at]
                      when "last 7 days" then
                        Time.now - 7.day
                      when "last month" then
                        Time.now - 31.day
                      when "last 3 months" then
                        Time.now - 3.month
                      when "last 6 months" then
                        Time.now - 6.month
                      when "last 12 months" then
                        Time.now - 12.month
                      else
                        10.years.ago
                      end
        with(:created_at).greater_than(date_range)
      end
      paginate(:page =>  params[:page], :per_page => 15) if params[:q].nil?
    end
    respond_with(@questions) do |format|
      format.js
      format.html
      format.json { render :json => @questions.results.map {|question| question.name }.to_json }
    end
  end
  
  def update_for_toggle_acceptance
    @question = current_user.questions.wh(params[:id])
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
  
  def question_state
    if params[:question].present? && params[:question][:question_state].present?
      params[:question][:question_state] == "true"? true : false
    end
  end
  
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
    else
      true
    end
  end
  
end
