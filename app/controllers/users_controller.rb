class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit ,:update, :destroy ]
  before_action :correct_user, only: [:edit ,:update ]
  before_action :admin_user, only: [:destroy ]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
    else
      flash[:danger] = "You need to log in"
      redirect_to 'new'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now

      flash[:info] = "Check your email to activate your account"

      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Attributes edited successfully"
      redirect_to @user
    else
      render 'edits'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "user deleted successfully"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger]="please log in first"
      redirect_to login_url
    end
  end

  def correct_user
    user = User.find(params[:id])
    unless current_user? user
      flash[:danger] = "you have been redirected"
      redirect_to root_url
    end
  end

  def admin_user
    unless get_current_user.admin
      flash[:danger] = "Not autherized"
      redirect_to root_url
    end
  end

end
