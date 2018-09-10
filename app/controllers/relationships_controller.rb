class RelationshipsController < ApplicationController
  before_action :logged_in_user? , only: [:create,:destroy]

  def create
    @user = User.find(params[:id])
    get_current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy

    @user = User.find(Relationship.find(params[:id]).followed_id)
    get_current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


  private

  def logged_in_user?
    if !logged_in?
      flash[:danger] = "You need to log in"
      redirect_to login_url
    end
  end

end
