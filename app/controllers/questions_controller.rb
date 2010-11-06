class QuestionsController < ApplicationController
  def new 
    @question = Question.new
    @category = @question.categories.build
  end

  def create      
    @question = (params[:question][:type].downcase == 'challenge') ? ChallengeQuestion.new(params[:question]) : SimpleQuestion.new(params[:question])
    @category = Category.new(params[:category]) # Just a stub does nothing
    @question.categorize(params[:category])
    @question.user = current_user    
    if @question.save
      flash[:notice] = "Question was successfully created and posted"
      redirect_to user_question_url(current_user, @question)
    else      
      flash.now[:error] = "Please fix the following errors"
      render "new"
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def edit
    @question = Question.find(params[:id])
    @category = Category.new(:title => @question.get_categories)
  end

  def update    
    @question = Question.find(params[:id])
    @category = Category.new(params[:category]) # Just a stub does nothing
    @question.categorize(params[:category])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Your question has been successfully updated"
      redirect_to user_question_url(current_user, @question)
    else
      flash.now[:error] = "Please fix the following errors"
      render "edit"
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.answers.empty?
      if @question.destroy
        flash[:notice] = "Thread was successfully deleted"
        redirect_to user_url(current_user)
      else
        flash[:error] = "This thread could not be deleted"
        redirect_to user_question_url(current_user, @question)
      end
    else
      flash[:error] = "This thread could not be deleted"
      redirect_to user_question_url(current_user, @question)
    end
  end
end
