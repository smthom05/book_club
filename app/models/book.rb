class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :authors
  validates :pages, presence: true, numericality: {
    greater_than: 0
  }
  validates :year_published, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 2019
  }

  def self.by_rating(order)
    if order == 'desc'
      Book.left_joins(:reviews).group(:id).order('avg(reviews.rating) desc')
    else
      Book.left_joins(:reviews).group(:id).order('avg(reviews.rating) asc')
    end
  end

  def self.by_page_count(order)
    if order == "asc"
      Book.order(:pages)
    else
      Book.order(pages: :desc)
    end
  end

  def self.by_number_of_reviews(order)
    if order == "asc"
      Book.left_joins(:reviews).group(:id).order('reviews.count asc')
    else
      Book.left_joins(:reviews).group(:id).order('reviews.count desc')
    end
  end

  def self.top_rated_books
    Book.joins(:reviews).group(:id).order('avg(reviews.rating) desc').limit(3)
  end

  def self.lowest_rated_books
    Book.joins(:reviews).group(:id).order('avg(reviews.rating) asc').limit(3)
  end

  def average_rating
    if reviews == []
      0
    else
      reviews.average(:rating).round(2)
    end
  end

  def number_of_reviews
    reviews.count
  end

  def top_review
    reviews.order(rating: :desc).first
  end

  def top_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def bottom_reviews
    reviews.order(:rating).limit(3)
  end
end
