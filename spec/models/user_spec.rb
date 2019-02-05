require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
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

    it '.top_users' do
      @book_2.reviews.create(title: "ghfkjgsfhjk", rating: 5, text: "I hate books", user: @user_2)
      expect(User.top_users).to eq([@user, @user_2, @user_3])
    end
  end

  describe 'instance methods' do
    before :each do
      @user = User.create(name: "Book Luvr")
      @author_1 = Author.create(name: "JRR Tolkien")
      @book_1 = Book.create(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      @author_2 = Author.create(name: "JK Rowling")
      @book_2 = Book.create(authors: [@author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      @review = @book_1.reviews.create(title: "Review Example", rating: 5, text: "jfadlskjf;kf", user: @user)
      @review_2 = @book_1.reviews.create(title: "Cool Book", rating: 5, text: "Cool", user: @user)
      @review_3 = @book_2.reviews.create(title: "Crappy Book", rating: 1, text: "Crappy", user: @user)
    end

    it '.newest_reviews_first' do
      expect(@user.newest_reviews_first).to eq([@review_3, @review_2, @review])
    end

    it '.number_of_reviews' do
      expect(@user.number_of_reviews).to eq(3)
    end
  end

end
