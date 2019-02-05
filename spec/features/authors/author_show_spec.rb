require 'rails_helper'

RSpec.describe 'author show page' do
  before :each do
    @user = User.create(name: 'Book luvr')
    @author = Author.create(name: "JRR Tolkien")
    @author_2 = Author.create(name: "Fake guy")
    @book_1 = Book.create(authors: [@author, @author_2], title: "Fellowship", pages: 400, year_published: 1954, image_url: "https://images-na.ssl-images-amazon.com/images/I/51tW-UJVfHL._SX321_BO1,204,203,200_.jpg")
    @book_2 = Book.create(authors: [@author, @author_2], title: "Towers", pages: 300, year_published: 1955, image_url: "https://images-na.ssl-images-amazon.com/images/I/4123zOAwAgL.jpg")
    @book_3 = Book.create(authors: [@author, @author_2], title: "King", pages: 500, year_published: 1956, image_url: "https://images-na.ssl-images-amazon.com/images/I/41fHC5yiRgL.jpg")
    @book_4 = Book.create(authors: [@author], title: "Something", pages: 200, year_published: 1957)
    @book_5 = Book.create(authors: [@author_2], title: "Book 5", pages: 100, year_published: 1958)
    @review = @book_1.reviews.create(title: "Review Example", rating: 5, text: "jfadlskjf;kf", user: @user)
    @review_2 = @book_1.reviews.create(title: "Cool Book", rating: 3, text: "Cool", user: @user)
    @review_3 = @book_2.reviews.create(title: "Awesome Book", rating: 5, text: "Awesome", user: @user)
    @review_4 = @book_2.reviews.create(title: "Crappy Book", rating: 1, text: "Crappy", user: @user)
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

  it 'shows a book title that is a link to the book show page' do
    visit author_path(@author)

    click_link "#{@book_1.title}"

    expect(current_path).to eq(book_path(@book_1))
  end

  it 'shows a link that deletes the author and all of his or her books' do
    visit author_path(@author)

    click_link "Delete Author"

    expect(current_path).to eq(books_path)
    expect(page).to have_content(@author_2.name)
    expect(page).to_not have_content(@author.name)
    expect(page).to have_content(@book_5.title)
    expect(page).to_not have_content(@book_1.title)
    expect(page).to_not have_content(@book_2.title)
    expect(page).to_not have_content(@book_3.title)
    expect(page).to_not have_content(@book_4.title)
  end

  it 'should have a link to the user show page in the top review' do
    visit author_path(@author)

    within "#top-review-#{@book_1.id}" do
      click_link "#{@user.name}"
    end
    expect(current_path).to eq(user_path(@user))
  end

  it 'should show me the highest rated review' do
    visit author_path(@author)

    within "#top-review-#{@book_1.id}" do
      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.rating)
      expect(page).to have_content(@review.user.name)
    end
    within "#top-review-#{@book_2.id}" do
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content(@review_3.rating)
      expect(page).to have_content(@review_3.user.name)
    end
    within "#top-review-#{@book_4.id}" do
      expect(page).to have_content("No Reviews Written")
    end

  end
end
