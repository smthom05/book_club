class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:order] == "new"
      @reviews = @user.newest_reviews_first
    else
      @reviews = @user.reviews
    end
  end
end
