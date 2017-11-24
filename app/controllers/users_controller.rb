class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :find_user, only: %i(show edit update destroy)
  def new
    @user = User.new
  end

  def show; end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "flash.info"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "flash.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.delete"
    else
      flash[:danger] = t "flash.undelete"
    end
    redirect_to users_url
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.danger"
    redirect_to signup_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.please"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
