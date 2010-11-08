class CommentsController < ApplicationController
  def create
    @associated_object, @comment = comment_for(params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Your comments have been successfully save"
      redirect_to question_url(@associated_object) and return if @associated_object.is_a? Question
      redirect_to question_url(@associated_object.question) and return if @associated_object.is_a? Answer
    else      
      flash[:error] = @comment.errors.full_messages[0] + " for comments"
      redirect_to question_url(@associated_object) and return if @associated_object.is_a? Question
      redirect_to question_url(@associated_object.question) and return if @associated_object.is_a? Answer      
    end
  end

  def update
  end

  def delete
  end

  private

  def comment_for(params)
    associated_object = comment =  nil
    if params[:question_id]
      associated_object = Question.find(params[:question_id])      
    else
      associated_object = Answer.find(params[:answer_id])      
    end
    comment = associated_object.comments.build(params[:comment])
    [associated_object, comment]
  end
end
