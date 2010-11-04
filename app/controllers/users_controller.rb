require "will_paginate"
class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Your account has been successfully created"
      redirect_to user_url(@user)
    else
      flash.now[:error] = "Please fix the errors"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @questions = Question.paginate(:page => params[:page], :per_page => 10)
    render :layout => "inner"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update    
    @user = current_user    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been successfully updated."
      redirect_to edit_user_url(@user)
    else      
      flash.now[:error] = "Your profile could not be updated."
      render "edit"
    end
  end

  def my_qa    
    @my_questions =  current_user.questions.paginate(:page => params[:page], :per_page => 10)
    @my_answers = current_user.answers.paginate(:page => params[:page], :per_page => 10)
  end

  def delete
  end

end
