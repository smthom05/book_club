require 'rails_helper'

RSpec.describe 'when a visitor visits the books index page' do
  before :each do
    @author_1 = Author.create(name: "JRR Tolkien")
    @author_2 = Author.create(name: "JK Rowling")
    @book_1 = Book.create(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    @book_2 = Book.create(authors: [@author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
    @book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [@author_1, @author_2], pages: 500, year_published: 2019, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    @user = User.create(name: "user")
    @review_1 = @book_1.reviews.create(title: "Review 1", rating: 5, text: "Fake", user: @user)
    @review_2 = @book_1.reviews.create(title: "Review 2", rating: 1, text: "Other", user: @user)
    @review_3 = @book_2.reviews.create(title: "Review 1 Book 2", rating: 5, text: "Faker", user: @user)
    @review_4 = @book_2.reviews.create(title: "Review 2 Book 2", rating: 2, text: "Fakest", user: @user)
  end

  it 'can see all books' do
    visit books_path

    within '#books' do
      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.authors.first.name)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.year_published)
        expect(page).to have_css("img[src*='#{@book_1.image_url}']")
      end
      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.authors.first.name)
        expect(page).to have_content("Page Count: #{@book_2.pages}")
        expect(page).to have_content("Year Published: #{@book_2.year_published}")
        expect(page).to have_css("img[src*='#{@book_2.image_url}']")
      end
      within "#book-#{@book_3.id}" do
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(@book_3.authors[0].name)
        expect(page).to have_content(@book_3.authors[1].name)
        expect(page).to have_content("Page Count: #{@book_3.pages}")
        expect(page).to have_content("Year Published: #{@book_3.year_published}")
        expect(page).to have_css("img[src*='#{@book_3.image_url}']")
      end
    end
  end

  it 'can click on a link and go to the show page for that book' do

    visit books_path

    click_link(@book_1.title)

    expect(current_path).to eq(book_path(@book_1))
  end

  it 'shows an average book rating and number of reviews for a book' do
    visit books_path

    within '#books' do
      within "#book-#{@book_1.id}" do
        expect(page).to have_content("Average Rating: #{@book_1.average_rating}")
        expect(page).to have_content("Number of reviews: #{@book_1.number_of_reviews}")
      end
      within "#book-#{@book_2.id}" do
        expect(page).to have_content("Average Rating: #{@book_2.average_rating}")
        expect(page).to have_content("Number of reviews: #{@book_2.number_of_reviews}")
      end
      within "#book-#{@book_3.id}" do
        expect(page).to have_content("Average Rating: #{@book_3.average_rating}")
        expect(page).to have_content("Number of reviews: #{@book_3.number_of_reviews}")
      end
    end
  end

  it 'shows me a link to sort the books by average rating in ascending order' do
    visit books_path

    expect(page).to have_link("Average Rating Ascending")

    click_link("Average Rating Ascending")

    expect(page.all('.individual-book')[0]).to have_content(@book_1.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_2.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_3.title)
  end

  it 'shows me a link to sort the books by average rating in ascending order' do
    visit books_path

    expect(page).to have_link("Average Rating Descending")

    click_link("Average Rating Descending")

    expect(page.all('.individual-book')[0]).to have_content(@book_3.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_2.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_1.title)
  end

  it 'shows me a link to sort the books by page count in ascending order' do
    visit books_path

    expect(page).to have_link("Page Count Ascending")

    click_link("Page Count Ascending")

    expect(page.all('.individual-book')[0]).to have_content(@book_2.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_3.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_1.title)
  end

  it 'shows me a link to sort the books by page count in descending order' do
    visit books_path

    expect(page).to have_link("Page Count Descending")

    click_link("Page Count Descending")

    expect(page.all('.individual-book')[0]).to have_content(@book_1.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_3.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_2.title)
  end

  it 'shows me a link to sort the books by number of reviews in ascending order' do
    @book_1.reviews.create(title: "Review 3", rating: 4, text: "Fakest of ALL", user: @user)

    visit books_path

    expect(page).to have_link("Number of Reviews Ascending")

    click_link("Number of Reviews Ascending")

    expect(page.all('.individual-book')[0]).to have_content(@book_3.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_2.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_1.title)
  end

  it 'shows me a link to sort the books by number of reviews in descending order' do
    @book_1.reviews.create(title: "Review 3", rating: 4, text: "Fakest of ALL", user: @user)

    visit books_path

    expect(page).to have_link("Number of Reviews Descending")

    click_link("Number of Reviews Descending")

    expect(page.all('.individual-book')[0]).to have_content(@book_1.title)
    expect(page.all('.individual-book')[1]).to have_content(@book_2.title)
    expect(page.all('.individual-book')[2]).to have_content(@book_3.title)
  end

  it 'shows a book title that is a link to the book show page' do
    visit books_path

    click_link "#{@book_1.title}"

    expect(current_path).to eq(book_path(@book_1))
  end

  it 'shows author name as a link that goes to author show page' do
    visit books_path

    within "#book-#{@book_1.id}" do
      click_link "#{@author_1.name}"
    end

    expect(current_path).to eq(author_path(@author_1))
  end

  describe 'within the statistics section' do
    before :each do
      @user_2 = User.create(name: "dumb")
      @user_3 = User.create(name: "fan")
      @user_4 = User.create(name: "lame")
      @book_4 = Book.create(title: "Good book", authors: [@author_2], pages: 90, year_published: 5)
      @review_4 = @book_3.reviews.create(title: "Review 1", rating: 5, text: "Fake", user: @user_2)
      @review_5 = @book_4.reviews.create(title: "Review fds", rating: 3, text: "Other", user: @user_2)
      @review_6 = @book_4.reviews.create(title: "Review fwff", rating: 5, text: "Faker", user: @user_3)
      @review_7 = @book_3.reviews.create(title: "Reldasf", rating: 4, text: "Faker", user: @user_4)
      @review_8 = @book_4.reviews.create(title: "Rfhjfhjkfhkjf", rating: 3, text: "Faker", user: @user_3)
    end

    it 'shows the top 3 highest rated books' do
      visit books_path

      within '#all-book-statistics' do
        within '#highest-rated-books' do
          expect(page).to have_content(@book_3.title)
          expect(page).to have_content("Rating: #{@book_3.average_rating}")

          expect(page).to have_content(@book_4.title)
          expect(page).to have_content("Rating: #{@book_4.average_rating}")

          expect(page).to have_content(@book_2.title)
          expect(page).to have_content("Rating: #{@book_2.average_rating}")
        end
      end
    end

    it 'shows the top 3 highest rated books' do
      visit books_path

      within '#all-book-statistics' do
        within '#lowest-rated-books' do
          expect(page).to have_content(@book_1.title)
          expect(page).to have_content("Rating: #{@book_1.average_rating}")

          expect(page).to have_content(@book_2.title)
          expect(page).to have_content("Rating: #{@book_2.average_rating}")

          expect(page).to have_content(@book_4.title)
          expect(page).to have_content("Rating: #{@book_4.average_rating}")
        end
      end
    end

    it 'shows the 3 users with the most reviews' do
      @book_3.reviews.create(title: "Review 8", rating: 5, text: "Fake", user: @user_2)

      visit books_path

      within '#all-book-statistics' do
        within '#most-active-users' do
          expect(page).to have_content(@user.name)
          expect(page).to have_content("Review Count: #{@user.number_of_reviews}")

          expect(page).to have_content(@user_2.name)
          expect(page).to have_content("Review Count: #{@user_2.number_of_reviews}")

          expect(page).to have_content(@user_3.name)
          expect(page).to have_content("Review Count: #{@user_3.number_of_reviews}")
        end
      end
    end

    it 'shows a user name which is a link to that user show page' do
      visit books_path

      within '#all-book-statistics' do
        within '#most-active-users' do
          click_link "#{@user.name}"
        end
      end

      expect(current_path).to eq(user_path(@user))
    end
  end
end
