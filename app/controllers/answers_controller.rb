class AnswersController < ApplicationController
  
  before_filter :require_user, :except => [:show, :index]
  before_filter :require_owner, :only => [:edit, :destroy]
  before_filter :require_question_owner, :only => :update_for_switch_acceptance
  
  
  def index
    if params[:question_id]
      redirect_to question_path(params[:question_id])
    end
  end
  
  def show
    @answer = Answer.find(params[:id])
    respond_to do |format|
        format.html { 
          render :partial => "/questions/answer", :locals => {:answer => @answer}
        }
    end
    
  end
  
  def edit
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.body = @answer.body
  end
  
  def create
    @answer = Answer.new(params[:answer])
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Answer was successfully created.'
        format.html { redirect_to question_url(@question.id, @question.friendly_id) }
      else
        format.html { render("_new", :locals => {:answer => @answer, :question => @question}, :layout => true) }
      end
    end
  end

  def update
    
    params.delete(:accepted)
    @answer = Answer.find(params[:id])
    @question = @answer.question
    
     if @answer.update_attributes(params[:answer])
       flash[:notice] = "Saved your answer."
         redirect_to question_path(@answer.question)
      else
          render "edit"
      end
  end


  def destroy
    
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def update_for_switch_acceptance
     
     @answer.toggle_acception
     respond_to do |format|
       format.js{
         render :update do |page|
             page["#answer_#{@answer.id} .status"].html render :partial => "/answers/status", :locals => {:answer => @answer}
         end
       }
     end
   end
  
  
  private
  
  def require_owner
    @answer = Answer.find_by_id_and_user_id(params[:id], current_user.id)
  end
  
  def require_question_owner
    logger.info "Calling filter require_question_owner"
    @answer = Answer.find(params[:answer_id])
    @question = Question.find_by_id_and_user_id(@answer.question_id, current_user.id)
    if @question
      true
    else
      false
    end
  end
    
  
end
