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

  def delete
  end

end
