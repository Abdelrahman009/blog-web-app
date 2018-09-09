class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = get_current_user.microposts.build
      @feed = get_current_user.feed.paginate(page: params[:page])
      "hi"
    end
  end

  def about
  end

  def contacts
  end

  def help
  end
end
