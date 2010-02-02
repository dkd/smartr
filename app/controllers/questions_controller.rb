class QuestionsController < ApplicationController
  
  before_filter :require_user, :only => [:edit, :new, :update, :destroy]
  before_filter :is_owner, :only => [:update, :destroy, :edit]
  
  def index
    
    if(params[:tag])
      index_for_tag
    elsif(params[:search])
      index_for_search
    else
      @questions = Question.latest.paginate :page => params[:page], :per_page => 20
      respond_to do |wants|
        wants.html {  }
        wants.xml { render "questions/rss/index" }
      end
      
    end
    
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    @question.update_views if @question.present?
    @answer = Answer.new
    @answer.question = @question
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @question.body = @question.body_plain
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @question.body = @question.body_plain
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
        else
          format.html { 
            @question.body = @question.body_plain
            render :action => "new" 
            }
        end
      end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    
    @question = Question.find(params[:id])
        
    if(params[:mode].present? && params[:mode] == "toggle_acceptance")
      update_for_toggle_acceptance
    else
      respond_to do |format|
        if @question.update_attributes(params[:question])
          flash[:notice] = 'Question was successfully updated.'
          format.html { redirect_to(@question) }
        else
          format.html { render :action => (params[:question][:answers_attributes]) ? "show" : "edit" }
        end
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
    end
  end
  
  
  def index_for_hot
    @questions = Question.hot.paginate :page => params[:page], :per_page => 20
  end
  
  def index_for_active
    @questions = Question.active.paginate :page => params[:page], :per_page => 20
  end
  
  def index_for_unanswered
    @questions = Question.unanswered.paginate :page => params[:page], :per_page => 20
  end
  
  
  def index_for_search
    
    page = params[:page] 
    logger.info "Searchstring"
    searchstring = params[:search][:searchstring]
    facet_user_id = params[:user_id] unless params[:user_id].nil?
    @questions = Sunspot.search(Question) do 
      fulltext searchstring do
        highlight :name, :body_plain, :max_snippets => 3, :fragment_size => 200
        tie 0.1    
      end
      with :user_id, facet_user_id unless facet_user_id.nil?
      facet :user_id
      
      paginate(:page =>  page, :per_page => 10)
    end
    
    render :index_for_search
  end
  
  protected
  
  def update_for_toggle_acceptance
    respond_to do |format|
      format.js{
        render :update do |page|
          
          @answer = Answer.find(params[:answer_id])
          
          if @answer
            
            answer_id = Reputation.toggle_acceptance(@question, @answer)
            
            page << "$('.answer-item .status a').removeClass('accepted')"
            page << "$('#answer_#{answer_id} .status a').addClass('accepted')" unless answer_id == 0
                          
          end
          
        end
      }
    end
  end  
  
  def index_for_tag
    @questions = Question.latest.tagged_with(params[:tag]).paginate :page => params[:page], :per_page => 20
  end
  
  def is_owner
    @question = Question.find(params[:id])
    if @question.user != current_user
      flash[:error] = "You are not the owner of the question!"
      redirect_to(question_path(@question))
    end
  end
  
end
