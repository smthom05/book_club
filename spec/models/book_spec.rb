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
  end

  describe 'instance methods' do
  end

end
