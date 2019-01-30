require 'rails_helper'

RSpec.describe 'when a visitor visits a book show page' do
  it 'shows the title, author(s), number of pages, and year_published' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = author_1.books.create(title: "Lord of the Rings", pages: 1000, year_published: 1955)
    book_2 = author_2.books.create(title: "The Prisoner of Azkaban", pages: 400, year_published: 1999)

    visit "/books/#{book_1.id}"

    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Author(s): #{book_1.authors.first.name}")
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year Published: #{book_1.year_published}")
    expect(page).to_not have_content("Title: #{book_2.title}")
  end

  it 'shows a list of reviews for a specific book' do
    author_1 = Author.create(name: "JRR Tolkien")
    book_1 = author_1.books.create(title: "Lord of the Rings", pages: 1000, year_published: 1955)
    user_1 = User.create(name: "LOTRfan1ring")
    user_2 = User.create(name: "LOTRhater")
    review_1 = user_1.reviews.create(title: "Awesome Book!", text: "This book had hobbits, orcs, elves, and all good stuff. Must read!", rating: 5, book: book_1)
    review_2 = user_2.reviews.create(title: "Crappy Book!", text: "This book had nothing good about it. Stay Away!", rating: 1, book: book_1)

    visit "/books/#{book_1.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_content("Title: #{review_1.title}")
      expect(page).to have_content("User Name: #{user_1.name}")
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content("Text: #{review_1.text}")
    end
    within "#review-#{review_2.id}" do
      expect(page).to have_content("Title: #{review_2.title}")
      expect(page).to have_content("Text: #{review_2.text}")
      expect(page).to have_content("Rating: #{review_2.rating}")
      expect(page).to have_content("User Name: #{user_2.name}")
    end
  end
end
