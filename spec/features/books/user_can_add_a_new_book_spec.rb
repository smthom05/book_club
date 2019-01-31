require 'rails_helper'

RSpec.describe 'When the user clicks on new book button', type: :feature do
  it 'sends user to a new book form page' do
    visit books_path

    click_on "Add New Book"

    expect(current_path).to eq(new_book_path)
  end

  describe 'when the user goes to the new book page' do
    describe 'and fills out the form with one author' do
      it 'should redirect to that books show page' do
        author_1 = Author.create(name: "JRR Tokien")
        book_1 = author_1.books.create(title: "Lord of the Rings", pages: 1000, year_published: 1955)

        visit new_book_path

        fill_in "book[title]", with: "The Wizard of Oz"
        fill_in "book[authors]", with: "L. Frank Baum"
        fill_in "book[pages]", with: 100
        fill_in "book[year_published]", with: 1900

        click_button 'Create Book'

        expect(page).to have_content("The Wizard of Oz")
        expect(page).to have_content("L. Frank Baum")
        expect(page).to have_content(100)
        expect(page).to have_content(1900)
        expect(page).to_not have_content(book_1.title)
      end

     it 'should render the form again if fields are empty' do
        visit new_book_path

        fill_in "book[title]", with: "The Wizard of Oz"
        fill_in "book[pages]", with: 100
        fill_in "book[year_published]", with: 1900

        click_button 'Create Book'

        expect(page).to have_button('Create Book')
        expect(page).to have_field("book[title]")
      end

      it 'should render the form again if fields are empty' do
         visit new_book_path

         click_button 'Create Book'

         expect(page).to have_button('Create Book')
         expect(page).to have_field("book[title]")
         within "#errors"
            ["Title can't be blank",
             "Authors can't be blank",
             "Pages can't be blank",

             "Pages is not a number",
             "Year published can't be blank",
             "Year published is not a number"].each do |msg|

           expect(page).to have_content(msg)
         end
       end
    end
  end
end
