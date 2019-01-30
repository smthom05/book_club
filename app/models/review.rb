class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :text, :title

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }

end
