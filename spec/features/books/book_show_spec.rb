require 'rails_helper'

RSpec.describe 'when a visitor visits a book show page' do
  it 'shows the title, author(s), number of pages, and year_published' do
    book_1 = Book.create(title: "Lord of the Rings", author: "J.R.R. Tolkien", pages: 1000, year_published: 1955)
    book_2 = Book.create(title: "The Prisoner of Azkaban", author: "J.K. Rowling", pages: 400, year_published: 1999)

    visit "/books/#{book_1.id}"

    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Author(s): #{book_1.author}")
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year Published: #{book_1.year_published}")
    expect(page).to_not have_content("Title: #{book_2.title}")
    expect(page).to_not have_content("Author(s): #{book_2.author}")
    expect(page).to_not have_content("Pages: #{book_2.pages}")
    expect(page).to_not have_content("Year Published: #{book_2.year_published}")
  end
end
