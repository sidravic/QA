class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    user_session = UserSession.new(params[:user_session])
    if user_session.save
      redirect_to user_url(current_user)
    else      
      flash.now[:error] = "Invalid username or password"
      render "new"
    end
  end

  def destroy    
    user_session = UserSession.find
    if user_session.destroy
      redirect_to root_url
    end
  end

end
