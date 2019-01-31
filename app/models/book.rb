class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title
  validates :pages, presence: true, numericality: {
    greater_than: 0
  }
  validates :year_published, presence: true, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 2019
  }
end
