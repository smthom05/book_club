class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def self.top_users
    joins(:reviews).select('users.*, count(reviews.id) as count_reviews')
    .group(:id).order("count_reviews desc").limit(3)
  end

  def number_of_reviews
    reviews.count
  end

  def newest_reviews_first
    reviews.order(created_at: :desc)
  end
end
