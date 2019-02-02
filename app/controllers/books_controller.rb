class BooksController < ApplicationController
  def index
    case params[:sort]
    when 'ratings'
      @books = Book.by_rating(params[:order])
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    bp = book_params
    if bp[:image_url] == ""
      bp[:image_url] = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAflBMVEX/xJz////bmWyhakr/1bigaEefZkS3kX2oeFydYj/TvrOaY0P5v5f/yKLal2nosIqudVKbXjjt5eGocVHgp4PIiWGoc1T/277gs5fn29XNs6XCoZCaXDb59fO5k3+wg2vdzcXZxbvFp5fPt6qxhW7q39rTk2n28e67f1rRmXacEEpjAAAC7ElEQVR4nO3YbXeaMBiAYYEFja6bkdXON9B1uu7//8FJ7Npz1hP0kHRPQu/7a9qe52oCgqNs6I2kB3j3EKYfwvRDmH4I0w/hS7v9uq7HMbf3Eh4aY3QZdWbqITwUWhWxp/sLd42J3+cjXJSl9PA31Vt43L5sYGUrqmVbFVM+wl/PV+Bsfp9f+vL1oe0uokYzD+HkckSrU56/Cj+duxvF02cP4dRY4DzPhyrUFviUD1b4aIVVPlzh0t5mTsMVLrb/XoRDE0712y0clnBjPyryAQsb9faQDks4QRhJCBEilA8hQoTyIUSIUD6ECBHKhxAhQvkQIkQoH0KECOVDiBChfAgRIpQPIUKE8iFEiFA+hAgRyocQIUL5ECJEKB9ChAjlQ4gQoXwIESKUDyFChPIhRIhQPoQIEcqHECFC+RAiRCgfQoQI5UOIEKF8CBEilA8hQoTyIUSIUD6ECBHKhxAhQvkQIkQoH0KECOVDiBChfAgRIpQPIUKE8iFEiFA+hAgRyocQIUL5ECJEKB9ChB9U+BCR8C6M8HT/t9/f277FlLfw9FQVr6lZdBWewvmsSKD+wurq346j/sJU8hWW2kSbDiAs9Wa/WsTayhK3Kw+hqXddPybduhWWG8fqLcLtIfxUIVu2YxrXJtwg1Ot3mCpgi23XFt4gVE34oYI2bQ+pcVyFtwi183cjaVO2UzqXrwtN8JEC15ynVBPn8lWh+hl8pMBV5ynL2rl8VViOg48UuKLzRjOEPSw89nDcXsMq+EiBs/vgvuF3Cu3DglkEnylstce9dGW6j3gcXdmHTmFm7FPpMfhQQbP7oB9dy93CH+2/R5VRP3dnmR1y6VrtFu7sJqoi7scaeyGavWO1W5hNL8TtOOaTurCbqBwn7YowG19eoEujlpNoU73f8dsa/fyer+Kt/7cYttp4f0n0X+ovPL9/6RS+c/MQZrv10ugy9oyH8NxxuqnHkef4uLhRmHAI0w9h+iFMP4TphzD9/gAYrjykfbvuxgAAAABJRU5ErkJggg=='
    end
    author_list = bp[:authors]
    authors = []
    author_list.split(',').each do |author|
      author = author.titleize.strip
      author_1 = Author.find_or_create_by(name: author)
      authors << author_1
    end
    bp[:authors] = authors
    @book = Book.new(bp)
    if Book.find_by(title: bp[:title])
      @error_msg = "Book already in system."
      render :new
    else
      if @book.save
        redirect_to book_path(@book)
      else
        render :new
      end
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year_published, :image_url)
  end
end
