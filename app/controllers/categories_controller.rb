class CategoriesController < ApplicationController
  def index
    @categories = Category.order('title ASC').includes(:questions).paginate(:page => params[:page], :per_page => 40)
  end

  def question
    @category = Category.find(params[:id])
    @questions = @category.questions.includes(:answers).paginate(:page => params[:page], :per_page => 20)
  end

end
