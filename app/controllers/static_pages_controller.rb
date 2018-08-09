class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @review  = current_user.reviews.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 5).search(params[:search],"review")
    end
  end
end
