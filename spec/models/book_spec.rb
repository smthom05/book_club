require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through :book_authors}
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :pages}
    it {should validate_presence_of :year_published}
    it { should validate_numericality_of(:pages).is_greater_than(0) }
    it { should validate_numericality_of(:year_published).is_less_than_or_equal_to(2019) }
    it { should validate_numericality_of(:year_published).is_greater_than_or_equal_to(0) }
  end

  describe 'class methods' do
    before :each do
      @author_1 = Author.create(name: "JRR Tolkien")
      @author_2 = Author.create(name: "JK Rowling")
      @book_1 = Book.create(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      @book_2 = Book.create(authors: [@author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      @book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [@author_1, @author_2], pages: 500, year_published: 2019, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      @user = User.create(name: "user")
      @book_1.reviews.create(title: "Review 1", rating: 3, text: "Fake", user: @user)
      @book_1.reviews.create(title: "Review 2", rating: 1, text: "Other", user: @user)
      @book_2.reviews.create(title: "Review 1 Book 2", rating: 3, text: "Faker", user: @user)
      @book_2.reviews.create(title: "Review 2 Book 2", rating: 1, text: "Fakest", user: @user)
      @book_2.reviews.create(title: "Review 3 Book 2", rating: 5, text: "Fakest by far", user: @user)
      @book_3.reviews.create(title: "Review 1 Book 3", rating: 1, text: "Most fakest by far", user: @user)
    end

    it '.by_rating' do
      expect(Book.by_rating("asc")).to eq([@book_3, @book_1, @book_2])
      expect(Book.by_rating("desc")).to eq([@book_2, @book_1, @book_3])
    end
  end

  describe 'instance methods' do
    before :each do
      @author_1 = Author.create(name: "JRR Tolkien")
      @author_2 = Author.create(name: "JK Rowling")
      @book_1 = Book.create(authors: [@author_1], title: "Lord of the Rings", pages: 1000, year_published: 1955, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      @book_2 = Book.create(authors: [@author_2], title: "The Prisoner of Azkaban", pages: 400, year_published: 1999, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      @book_3 = Book.create(title: "LOTR MEETS HARRY POTTER", authors: [@author_1, @author_2], pages: 500, year_published: 2019, image_url: "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif")
      @user = User.create(name: "user")
      @book_1.reviews.create(title: "Review 1", rating: 5, text: "Fake", user: @user)
      @book_1.reviews.create(title: "Review 2", rating: 1, text: "Other", user: @user)
      @book_2.reviews.create(title: "Review 1 Book 2", rating: 3, text: "Faker", user: @user)
      @book_2.reviews.create(title: "Review 2 Book 2", rating: 1, text: "Fakest", user: @user)
      @book_2.reviews.create(title: "Review 3 Book 2", rating: 2, text: "Fakest by far", user: @user)
    end

    it '.average_rating' do
      expect(@book_1.average_rating).to eq(3)
      expect(@book_2.average_rating).to eq(2)
      expect(@book_3.average_rating).to eq("No reviews written")
    end

    it '.number_of_reviews' do
      expect(@book_1.number_of_reviews).to eq(2)
      expect(@book_2.number_of_reviews).to eq(3)
      expect(@book_3.number_of_reviews).to eq(0)
    end
  end

end
