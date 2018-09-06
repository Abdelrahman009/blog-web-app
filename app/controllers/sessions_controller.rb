class SessionsController < ApplicationController
  def new
  end

  def create

    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      remember @user
      redirect_to @user
    else
      flash.now[:danger] = "invalid E-mail or password"
      render 'sessions/new'
    end

  end

  def destroy
    log_out
    render "static_pages/home"
  end

end
