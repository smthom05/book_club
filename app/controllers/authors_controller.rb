class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def destroy
    book_ids = Author.find(params[:id]).book_ids
    book_ids.each do |book_id|
      Review.where(book_id: book_id).destroy_all
      BookAuthor.where(book_id: book_id).destroy_all
      Book.find(book_id).destroy
    end

    Author.find(params[:id]).destroy
    
    redirect_to books_path
  end


end
