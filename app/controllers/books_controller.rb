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
    bp = book_params
    author_list = bp[:authors]
    authors = []
    author_list.split(',').each do |author|
      author = author.titleize.strip
      author_1 = Author.find_or_create_by(name: author)
      authors << author_1
    end
    bp[:authors] = authors
    @book = Book.new(bp)
    if @book.save
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
