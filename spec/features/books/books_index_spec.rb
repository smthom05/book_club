require 'rails_helper'

RSpec.describe 'when a visitor visits the books index page' do
  it 'can see all books' do
    book_1 = Book.create(title: "Lord of the Rings", author: "J.R.R. Tolkien", pages: 1000, year_published: 1955)
    book_2 = Book.create(title: "The Prisoner of Azkaban", author: "J.K. Rowling", pages: 400, year_published: 1999)

    visit '/books'

    within '#books' do
      expect(page).to have_content("All Books")
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_1.author)
      expect(page).to have_content(book_2.author)
      expect(page).to have_content(book_1.pages)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_1.year_published)
      expect(page).to have_content(book_2.year_published)
    end
  end
end
