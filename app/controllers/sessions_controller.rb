class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        if params[:session][:remember_me] == '1'
          remember @user
        else
          forget @user
        end
        redirect_to @user
      else
        flash[:warning] = "Activate your account first"
        redirect_to root_url
      end

    else
      flash.now[:danger] = "invalid E-mail or password"
      render 'sessions/new'
    end

  end

  def destroy
    log_out if logged_in?
    render "static_pages/home"
  end

end
