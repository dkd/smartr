class AnswersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :require_owner, :only => [:edit, :destroy]
  before_filter :require_question_owner, :only => [:update_for_switch_acceptance]

  def edit
    @question = @answer.question
  end

  def create
    @answer = Answer.new(params[:answer])
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Answer was successfully created.'
      redirect_to question_url(@question.id, @question.friendly_id)
    else
      render "new"
    end

  end

  def update
    params.delete(:accepted)
    @answer = current_user.answers.find(params[:id])
    @question = @answer.question

    if @answer.update_attributes(params[:answer])
      flash[:notice] = 'Answer was successfully updated.'
      redirect_to question_path(@question.id, @question.friendly_id)
    else
      render "edit"
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
    @answer = current_user.answers.find(params[:id])
  end

  def require_question_owner
    @answer = Answer.find(params[:answer_id])
    @question = Question.find_by_id_and_user_id(@answer.question_id, current_user.id)
    if @question.present?
      true
    else
      false
    end
  end

end