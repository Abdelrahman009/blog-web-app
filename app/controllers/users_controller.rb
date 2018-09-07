class UsersController < ApplicationController
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
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "You created a new account"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update

  end

  def edit

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name, :email, :password,
                                 :password_confirmation)
  end
end
