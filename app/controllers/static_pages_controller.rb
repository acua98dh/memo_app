class StaticPagesController < ApplicationController
  def home
     @review = current_user.reviews.build if signed_in?
  end
end
