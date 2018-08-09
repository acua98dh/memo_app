class UsersController < ApplicationController
    before_action :require_login, only: [:index, :new, :create]
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page], :per_page => 5)
  end
end
