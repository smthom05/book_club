require 'rails_helper'

RSpec.describe 'user show page' do
  describe "when I click on a user's name" do
    before :each do
      @user = User.create(name: "Book Luvr")
      author_1 = Author.create(name: "JRR Tolkien")
      @book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      author_2 = Author.create(name: "JK Rowling")
      @book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      @review = @book_1.reviews.create(title: "Review Example", rating: 5, text: "jfadlskjf;kf", user: @user)
    end

    it 'takes me to a users show page' do
      visit book_path(@book_1)

      within "#review-#{@review.id}" do
        click_link "Book Luvr"
      end

      expect(current_path).to eq(user_path(@user))
    end

    it 'shows me all the users reviews' do
      visit new_book_review_path(@book_2)

      fill_in "review[title]", with: "Best Book"
      fill_in "review[user]", with: "Book luvr"
      fill_in "review[text]", with: "This was fine."
      fill_in "review[rating]", with: 3

      click_button "Create Review"

      click_link "Book Luvr"

      within "#review-#{@user.reviews[0].id}" do
        expect(page).to have_content(@user.reviews[0].title)
        expect(page).to have_content(@user.reviews[0].text)
        expect(page).to have_content(@user.reviews[0].rating)
        expect(page).to have_content(@book_1.title)
        expect(page).to have_css("img[src*='#{@book_1.image_url}']")
        expect(page).to have_content(@book_1.created_at)
      end

      within "#review-#{@user.reviews[1].id}" do
        expect(page).to have_content(@user.reviews[1].title)
        expect(page).to have_content(@user.reviews[1].text)
        expect(page).to have_content(@user.reviews[1].rating)
        expect(page).to have_content(@book_2.title)
        expect(page).to have_css("img[src*='#{@book_2.image_url}']")
        expect(page).to have_content(@book_2.created_at)
      end
    end

    it 'shows a book title that is a link to the book show page' do
      visit user_path(@user)

      within "#review-#{@review.id}" do
        click_link "#{@book_1.title}"
      end

      expect(current_path).to eq(book_path(@book_1))
    end

    it 'can delete an exisiting review' do
      visit user_path(@user)

      within "#review-#{@review.id}" do
        click_link "Delete Review"
      end

      expect(current_path).to eq(user_path(@user))
      expect(page).to_not have_content(@review.title)
    end
  end
end
