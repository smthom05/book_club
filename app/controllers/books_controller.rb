class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    author_1 = Author.new(name: book_params[:authors])
    @book = author_1.books.new(title: book_params[:title], pages: book_params[:pages], year_published: book_params[:year_published])
    if author_1.save
      @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year_published)
  end
end
