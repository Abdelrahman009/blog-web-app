class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create,:destroy,:update]
  before_action :correct_user , only: [:destroy ,:update]
  def create
    @micropost = get_current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Tweeted successfully"
      redirect_to root_url
    else
      flash[:danger] = "Check the letters count in the post"
      redirect_to get_current_user
    end

  end

  def update
  end

  def destroy
    @micropost.destroy
    flash[:success] = "the tweet is deleted"
    redirect_to request.referer || root_url
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger]="please log in first"
      redirect_to login_url
    end
  end

  def micropost_params
    params.require(:micropost).permit(:content,:picture)
  end

  def correct_user
    @micropost = get_current_user.microposts.find_by(id: params[:id])
    redirect_to root_url unless @micropost
  end

end
