module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def get_current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end

  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
  end

  def logged_in?
    !get_current_user.nil?
  end

  def log_out
    forget(get_current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end