class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # ログイン成功時の処理
      log_in user
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "Logged out!"
  end
end
