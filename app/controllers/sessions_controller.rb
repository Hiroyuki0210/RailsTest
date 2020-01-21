class SessionsController < ApplicationController
  # フォーム画面に関するアクション
  def new
  end

  # フォーム送信ボタンを押した後に起こるアクション
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # ログアウトに関するアクション
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
