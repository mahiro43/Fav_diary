class ApplicationController < ActionController::Base
  helper_method :log_in, :current_user, :logged_in?
  
  def log_in(user)
    session[:user_id] = user.id
  end
    
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
    
  def logged_in?
    !current_user.nil?
  end
end
