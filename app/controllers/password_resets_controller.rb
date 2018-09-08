class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit,:update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_password_digest
      @user.send_reset_password_email
      flash[:info] = "reset link was sent via email"
      redirect_to login_path
    else
      flash.now[:danger] = "No such user"
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.reset_password_expired?
      flash.now[:danger] = "Your password reset expired"
      render new_password_reset_url
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "password changed successfully"
      redirect_to @user
    else
      flash.now[:danger] = "passwords don't match"
      render 'edit'
    end
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
    unless @user && @user.activated? && @user.authenticated?(:reset,params[:id])
      flash[:danger] = "invalid email or token"
      redirect_to new_password_reset_path
    end
  end

  def user_params
    params.require(:user).permit( :password,
                                 :password_confirmation)
  end
end
