require 'rails_helper'

RSpec.describe 'when a visitor visits the books index page' do
  it 'can see all books' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
    book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [author_1, author_2], pages: 500, year_published: 2019, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    visit books_path

    within '#books' do
      within "#book-#{book_1.id}" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content(book_1.authors.first.name)
        expect(page).to have_content(book_1.pages)
        expect(page).to have_content(book_1.year_published)
        expect(page).to have_css("img[src*='#{book_1.image_url}']")
      end
      within "#book-#{book_2.id}" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content(book_2.authors.first.name)
        expect(page).to have_content(book_2.pages)
        expect(page).to have_content(book_2.year_published)
        expect(page).to have_css("img[src*='#{book_2.image_url}']")
      end
      within "#book-#{book_3.id}" do
        expect(page).to have_content(book_3.title)
        expect(page).to have_content(book_3.authors[0].name)
        expect(page).to have_content(book_3.authors[1].name)
        expect(page).to have_content(book_3.pages)
        expect(page).to have_content(book_3.year_published)
        expect(page).to have_css("img[src*='#{book_3.image_url}']")
      end
    end
  end

  it 'can click on a link and go to the show page for that book' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955)
    book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999)

    visit books_path

    click_link(book_1.title)

    expect(current_path).to eq(book_path(book_1))
  end
end
