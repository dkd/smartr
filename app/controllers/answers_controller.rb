class AnswersController < ApplicationController
  
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :is_owner, :only => [:edit, :update, :destroy]
  
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
    @answer.body = @answer.body_plain
    
  end
  
  def new
    
  end
  
  def create
    @answer = Answer.new(params[:answer])
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Answer was successfully created.'
        format.html { redirect_to(@question) } 
      else
        format.html {  render :partial => "/answers/new", :locals => {:answer => @answer, :question => @question}, :layout => true} 
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    if @answer.update_attributes(params[:answer])
      flash[:notice] = "Saved your answer."
        redirect_to question_path(@answer.question)
    else
        render "edit"
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def is_owner
    @answer = Answer.find_by_id_and_user_id(params[:id], current_user.id)
  end
    
  
end
