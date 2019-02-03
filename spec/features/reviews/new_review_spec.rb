require 'rails_helper'

RSpec.describe 'When the user clicks on new review button', type: :feature do
  before :each do
    author_1 = Author.create(name: "JRR Tolkien")
    @book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
  end

  it 'shows me a form where a user can enter review title, user name, rating and text' do


    visit new_book_review_path(@book_1)

    expect(page).to have_field("review[title]")
    expect(page).to have_field("review[user]")
    expect(page).to have_field("review[text]")
    expect(page).to have_field("review[rating]")
  end

  it 'user can create new review that goes to book show page' do

    visit new_book_review_path(@book_1)

    fill_in "review[title]", with: "Great Book"
    fill_in "review[user]", with: "BookLuvr"
    fill_in "review[text]", with: "This was a great book."
    fill_in "review[rating]", with: 5

    click_button "Create Review"

    expect(page).to have_content("Great Book")
    expect(page).to have_content("Book Luvr")
    expect(page).to have_content("This was a great book.")
    expect(page).to have_content("5")
    expect(current_path).to eq(book_path(@book_1))
  end

  it 're-renders the page if fields are empty' do
    visit new_book_review_path(@book_1)

    fill_in "review[title]", with: "Great Book"
    fill_in "review[user]", with: "BookLuvr"
    fill_in "review[rating]", with: 5

    click_button "Create Review"

    expect(page).to have_button("Create Review")
  end
end
