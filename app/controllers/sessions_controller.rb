class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      valid_user user
    else
      flash.now[:danger] = t "flash.invalid"
      render :new
      invalid_user
    end
  end

  def valid_user user
    log_in user
    params[:session][:remember_me] == Settings.remember.ischeck ? remember(user) : forget(user)
    redirect_to user
  end

  def invalid_user
    flash.now[:danger] = t "flash.invalid"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
