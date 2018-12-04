class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_email_params)
    if user && user.authenticate(session_password_params[:password])
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, info: 'ログアウトしました'
  end

  private
  def session_email_params
    params.require(:session).permit(:email)
  end

  def session_password_params
    params.require(:session).permit(:password)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
