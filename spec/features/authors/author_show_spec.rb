require 'rails_helper'

RSpec.describe 'author show page' do
  before :each do
    @author = Author.create(name: "JRR Tolkien")
    @author_2 = Author.create(name: "Fake guy")
    @book_1 = Book.create(authors: [@author, @author_2], title: "Fellowship", pages: 400, year_published: 1954, image_url: "https://images-na.ssl-images-amazon.com/images/I/51tW-UJVfHL._SX321_BO1,204,203,200_.jpg")
    @book_2 = Book.create(authors: [@author, @author_2], title: "Towers", pages: 300, year_published: 1955, image_url: "https://images-na.ssl-images-amazon.com/images/I/4123zOAwAgL.jpg")
    @book_3 = Book.create(authors: [@author, @author_2], title: "King", pages: 500, year_published: 1956, image_url: "https://images-na.ssl-images-amazon.com/images/I/41fHC5yiRgL.jpg")
  end

  it 'shows me all books by the author' do
    visit author_path(@author)

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@author_2.name)
      expect(page).to have_content(@book_1.pages)
      expect(page).to have_content(@book_1.year_published)
      expect(page).to have_css("img[src*='#{@book_1.image_url}']")
      expect(page).to_not have_content(@author.name)

    end
    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@author_2.name)
      expect(page).to have_content("Page Count: #{@book_2.pages}")
      expect(page).to have_content("Year Published: #{@book_2.year_published}")
      expect(page).to have_css("img[src*='#{@book_2.image_url}']")
      expect(page).to_not have_content(@author.name)
    end
  end
end
