require 'rails_helper'

RSpec.describe 'when a visitor visits a book show page' do
  it 'shows the title, author(s), number of pages, and year_published' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")

    visit book_path(book_1)

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Author(s): #{book_1.authors.first.name}")
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year Published: #{book_1.year_published}")
    expect(page).to have_css("img[src*='#{book_1.image_url}']")
    expect(page).to_not have_content("Title: #{book_2.title}")
  end

  it 'shows a list of reviews for a specific book' do
    author_1 = Author.create(name: "JRR Tolkien")
    book_1 = Book.create!(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955)
    user_1 = User.create(name: "LOTRfan1ring")
    user_2 = User.create(name: "LOTRhater")
    review_1 = user_1.reviews.create(title: "Awesome Book!", text: "This book had hobbits, orcs, elves, and all good stuff. Must read!", rating: 5, book: book_1)
    review_2 = user_2.reviews.create(title: "Crappy Book!", text: "This book had nothing good about it. Stay Away!", rating: 1, book: book_1)

    visit book_path(book_1)

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

  it 'shows a link to delete a book and it that book no longer appears on book index page' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")

    visit book_path(book_1)

    click_link "Delete Book"

    expect(current_path).to eq(books_path)
    expect(page).to have_content(book_2.title)
    expect(page).to_not have_content(book_1.title)
  end

  it 'shows the authors name as a link to the author show page' do
    author_1 = Author.create(name: "JRR Tolkien")
    author_2 = Author.create(name: "JK Rowling")
    book_1 = Book.create(authors: [author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
    book_2 = Book.create(authors: [author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
    visit book_path(book_1)

    within "#book-#{book_1.id}" do
      click_link "#{author_1.name}"
    end

    expect(current_path).to eq(author_path(author_1))
  end

  describe 'in the area for statistics' do
    before :each do
      @author_1 = Author.create(name: "JRR Tolkien")
      @book_1 = Book.create!(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955)
      @user_1 = User.create(name: "LOTRfan1ring")
      @user_2 = User.create(name: "LOTRhater")
      @review_1 = @user_1.reviews.create(title: "Once", text: "This book had hobbits, orcs, elves, and all good stuff. Must read!", rating: 1, book: @book_1)
      @review_2 = @user_2.reviews.create(title: "Twice", text: "This book had nothing good about it. Stay Away!", rating: 2, book: @book_1)
      @review_3 = @user_1.reviews.create(title: "Thrice", text: "another test", rating: 3, book: @book_1)
      @review_4 = @user_1.reviews.create(title: "uhhh four", text: "gdhjkfghs", rating: 4, book: @book_1)
      @review_5 = @user_1.reviews.create(title: "five", text: "bfhjkdslghl", rating: 5, book: @book_1)
    end

    it 'shows the top three reviews (title, rating and user) for this book' do
      visit book_path(@book_1)

      within "#statistics" do
        within "#top-review-#{@review_5.id}" do
          expect(page).to have_content(@review_5.title)
          expect(page).to have_content(@review_5.rating)
          expect(page).to have_content(@review_5.user.name)
        end

        within "#top-review-#{@review_4.id}" do
          expect(page).to have_content(@review_4.title)
          expect(page).to have_content(@review_4.rating)
          expect(page).to have_content(@review_4.user.name)
        end

        within "#top-review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content(@review_3.rating)
          expect(page).to have_content(@review_3.user.name)
        end
      end
    end

    it 'shows the bottom three reviews (title, rating and user) for this book' do
      visit book_path(@book_1)

      within "#statistics" do
        within "#bottom-review-#{@review_1.id}" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_1.rating)
          expect(page).to have_content(@review_1.user.name)
        end

        within "#bottom-review-#{@review_2.id}" do
          expect(page).to have_content(@review_2.title)
          expect(page).to have_content(@review_2.rating)
          expect(page).to have_content(@review_2.user.name)
        end

        within "#bottom-review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content(@review_3.rating)
          expect(page).to have_content(@review_3.user.name)
        end
      end
    end

    it 'shows the visitor the overall average of all reviews for this book' do
      visit book_path(@book_1)

      within '#statistics' do
        within '#average-rating' do
          expect(page).to have_content("Average Rating: #{@book_1.average_rating}")
        end
      end
    end

    it 'takes the visitor to a user show page when they click the user name' do
      visit book_path(@book_1)

      within "#statistics" do
        within "#top-review-#{@review_5.id}" do
          click_link "#{@review_5.user.name}"
        end
      end

      expect(current_path).to eq(user_path(@user_1))
    end
  end
end
