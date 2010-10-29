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
      flash[:error] = "Please fix the errors"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end

end
