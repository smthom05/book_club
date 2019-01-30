require 'rails_helper'

RSpec.describe 'when a visitor visits the books index page' do
  it 'can see all books' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = author_1.books.create(title: "Lord of the Rings", pages: 1000, year_published: 1955)
    book_2 = author_2.books.create(title: "The Prisoner of Azkaban", pages: 400, year_published: 1999)
    book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [author_1, author_2], pages: 500, year_published: 2019)
    visit books_path

    within '#books' do
      within "#book-#{book_1.id}" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content(book_1.authors.first.name)
        expect(page).to have_content(book_1.pages)
        expect(page).to have_content(book_1.year_published)
      end
      within "#book-#{book_2.id}" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content(book_2.authors.first.name)
        expect(page).to have_content(book_2.pages)
        expect(page).to have_content(book_2.year_published)
      end
      within "#book-#{book_3.id}" do
        expect(page).to have_content(book_3.title)
        expect(page).to have_content(book_3.authors[0].name)
        expect(page).to have_content(book_3.authors[1].name)
        expect(page).to have_content(book_3.pages)
        expect(page).to have_content(book_3.year_published)
      end
    end
  end
end
