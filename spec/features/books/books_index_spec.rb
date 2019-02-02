require 'rails_helper'

RSpec.describe 'when a visitor visits the books index page' do
  before :each do
    @author_1 = Author.create(name: "JRR Tolkien")
    @author_2 = Author.create(name: "JK Rowling")
    @book_1 = Book.create(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    @book_2 = Book.create(authors: [@author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
    @book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [@author_1, @author_2], pages: 500, year_published: 2019, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    user = User.create(name: "user")
    @review_1 = @book_1.reviews.create(title: "Review 1", rating: 5, text: "Fake", user: user)
    @review_2 = @book_1.reviews.create(title: "Review 2", rating: 1, text: "Other", user: user)
    @review_3 = @book_2.reviews.create(title: "Review 1 Book 2", rating: 5, text: "Faker", user: user)
    @review_4 = @book_2.reviews.create(title: "Review 2 Book 2", rating: 2, text: "Fakest", user: user)
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

  xit 'shows me a link to sort the books by average rating in ascending order' do
    visit books_path

    expect(page).to have_link("Average Rating Ascending")

    click_link("Average Rating Ascending")

    expect(page.all('.individual-book')[0]).to have_content('LOTR MEETS HARRY POTTER')
    expect(page.all('.individual-book')[1]).to have_content('Lord of the Rings')
    expect(page.all('.individual-book')[2]).to have_content("Prisoner of Azkaban")

  end
end

# As a Visitor,
# When I visit the book index page,
# Next to each book title, I see its average book rating
# And I also see the total number of reviews for the book.

# As a Visitor,
# When I visit the book index page,
# I should see one link each to sort the books by the following criteria:
# - sorted by average rating in ascending order
# - sorted by average rating in descending order
# - sorted by number of pages in ascending order
# - sorted by number of pages in descending order
# - sorted by number of reviews in ascending order
# - sorted by number of reviews in descending order
