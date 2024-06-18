class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン成功時の処理
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to favs_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: "ログアウトしました"
  end
end
