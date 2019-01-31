class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    rp = review_params
    rp[:user] = rp[:user].titleize.strip
    user = User.find_or_create_by(name: rp[:user])
    rp[:user] = user
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(rp)
    if @review.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :user, :text, :rating)
  end
end
