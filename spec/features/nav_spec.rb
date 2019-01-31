RSpec.describe 'navigation bar', type: :feature do
  describe 'from the books index page' do
    it 'allows users to go to home page' do
      visit books_path

      click_on 'Home'

      expect(current_path).to eq(root_path)
    end
  end

  describe 'from the home page' do
    it 'allows users to go to books index page' do
      visit root_path
      
      click_on 'Books'

      expect(current_path).to eq(books_path)
    end
  end
end
