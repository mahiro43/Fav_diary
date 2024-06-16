class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :log_in, :current_user, :logged_in?

  add_flash_types :success, :info, :warning, :danger
  
  def log_in(user)
    session[:user_id] = user.id
  end
    
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
    
  def logged_in?
    !current_user.nil?
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
