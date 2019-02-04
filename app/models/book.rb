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

  def average_rating
    if reviews == []
      0
    else
      reviews.average(:rating)
    end
  end

  def number_of_reviews
    reviews.count
  end

  def top_review
    reviews.order(rating: :desc).first
  end

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
end
