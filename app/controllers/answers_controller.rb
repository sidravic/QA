class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(params[:answer])
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Your answer was successfully saved"
      redirect_to question_url(@question)
    else
      flash.now[:error] = "Please fix the following errors"  
      render :template => "questions/show"
    end
  end

  def edit
    @answer =  Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
      flash[:notice] = "Your answer has been successfully updated"
      redirect_to question_url(@answer.question)
    else
      flash.now[:error] = "Please fix the following errors"
      render "edit"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])   
    if current_user == @answer.user      
      if @answer.destroy
        flash[:notice] = "Your answer has been successfully deleted"        
        redirect_to question_url(@answer.question)
      else        
        flash[:error] = "Oops your answer could not be deleted"
        redirect_to question_url(@answer.question)
      end
    end
  end

end
