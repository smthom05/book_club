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

    it '.by_page_count' do
      expect(Book.by_page_count("asc")).to eq([@book_2, @book_3, @book_1])
      expect(Book.by_page_count("desc")).to eq([@book_1, @book_3, @book_2])
    end

    it '.by_number_of_reviews' do
      expect(Book.by_number_of_reviews("asc")).to eq([@book_3, @book_1, @book_2])
      expect(Book.by_number_of_reviews("desc")).to eq([@book_2, @book_1, @book_3])
    end

    it '.top_rated_books' do
      @book_4 = Book.create(authors: [@author_2], title: "The Chamber baby", pages: 100, year_published: 456, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      expect(Book.top_rated_books).to eq([@book_2, @book_1, @book_3])
    end

    it '.lowest_rated_books' do
      @book_4 = Book.create(authors: [@author_2], title: "The Chamber baby", pages: 100, year_published: 456, image_url: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg")
      expect(Book.lowest_rated_books).to eq([@book_3, @book_1, @book_2])
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
      @review_1 = @book_1.reviews.create(title: "Review 1", rating: 5, text: "Fake", user: @user)
      @review_2 = @book_1.reviews.create(title: "Review 2", rating: 1, text: "Other", user: @user)
      @review_3 = @book_2.reviews.create(title: "Review 1 Book 2", rating: 3, text: "Faker", user: @user)
      @review_4 = @book_2.reviews.create(title: "Review 2 Book 2", rating: 1, text: "Fakest", user: @user)
      @review_5 = @book_2.reviews.create(title: "Review 3 Book 2", rating: 2, text: "Fakest by far", user: @user)
      @review_6 = @book_2.reviews.create(title: "Review 4 Book 2", rating: 5, text: "Fakest by far", user: @user)
    end

    it '.average_rating' do
      expect(@book_1.average_rating).to eq(3)
      expect(@book_3.average_rating).to eq(0)
    end

    it '.number_of_reviews' do
      expect(@book_1.number_of_reviews).to eq(2)
      expect(@book_2.number_of_reviews).to eq(4)
      expect(@book_3.number_of_reviews).to eq(0)
    end

    it '.top_review' do
      expect(@book_1.top_review).to eq(@review_1)
      expect(@book_2.top_review).to eq(@review_6)
    end

    it '.top_reviews' do
      expect(@book_2.top_reviews).to eq([@review_6, @review_3, @review_5])
    end

    it '.bottom_reviews' do
      expect(@book_2.bottom_reviews).to eq([@review_4, @review_5, @review_3])
    end
  end
end
