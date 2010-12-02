require 'constants'
require 'rdiscount'
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  helper_method :current_user_session
  helper_method :current_user
  helper_method :convert_to_html
  helper_method :get_categories
  include Constants
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def convert_to_html(text)
    RDiscount.new(text).to_html
  end  
end
