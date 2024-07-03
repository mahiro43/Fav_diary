class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :log_in, :current_user,:current_user?, :logged_in?

  add_flash_types :success, :info, :warning, :danger
  
  def log_in(user)
    session[:user_id] = user.id
  end
    
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    user == current_user
  end
    
  def logged_in?
    !!current_user
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end
end
