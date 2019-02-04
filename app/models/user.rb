class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def newest_reviews_first
    reviews.order(created_at: :desc)
  end
end
