require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
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
  end

end
