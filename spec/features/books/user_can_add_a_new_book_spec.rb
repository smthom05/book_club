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
        fill_in "book[image_url]", with: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg"

        click_button 'Create Book'

        expect(page).to have_content("The Wizard of Oz")
        expect(page).to have_content("L. Frank Baum")
        expect(page).to have_content(100)
        expect(page).to have_content(1900)
        expect(page).to_not have_content(book_1.title)
        expect(page).to have_css("img[src*='https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg']")

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

       it 'should default to a book image with an empty image field' do
         author_1 = Author.create(name: "JRR Tokien")
         book_1 = author_1.books.create(title: "Lord of the Rings", pages: 1000, year_published: 1955)
         default_image = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAflBMVEX/xJz////bmWyhakr/1bigaEefZkS3kX2oeFydYj/TvrOaY0P5v5f/yKLal2nosIqudVKbXjjt5eGocVHgp4PIiWGoc1T/277gs5fn29XNs6XCoZCaXDb59fO5k3+wg2vdzcXZxbvFp5fPt6qxhW7q39rTk2n28e67f1rRmXacEEpjAAAC7ElEQVR4nO3YbXeaMBiAYYEFja6bkdXON9B1uu7//8FJ7Npz1hP0kHRPQu/7a9qe52oCgqNs6I2kB3j3EKYfwvRDmH4I0w/hS7v9uq7HMbf3Eh4aY3QZdWbqITwUWhWxp/sLd42J3+cjXJSl9PA31Vt43L5sYGUrqmVbFVM+wl/PV+Bsfp9f+vL1oe0uokYzD+HkckSrU56/Cj+duxvF02cP4dRY4DzPhyrUFviUD1b4aIVVPlzh0t5mTsMVLrb/XoRDE0712y0clnBjPyryAQsb9faQDks4QRhJCBEilA8hQoTyIUSIUD6ECBHKhxAhQvkQIkQoH0KECOVDiBChfAgRIpQPIUKE8iFEiFA+hAgRyocQIUL5ECJEKB9ChAjlQ4gQoXwIESKUDyFChPIhRIhQPoQIEcqHECFC+RAiRCgfQoQI5UOIEKF8CBEilA8hQoTyIUSIUD6ECBHKhxAhQvkQIkQoH0KECOVDiBChfAgRIpQPIUKE8iFEiFA+hAgRyocQIUL5ECJEKB9ChB9U+BCR8C6M8HT/t9/f277FlLfw9FQVr6lZdBWewvmsSKD+wurq346j/sJU8hWW2kSbDiAs9Wa/WsTayhK3Kw+hqXddPybduhWWG8fqLcLtIfxUIVu2YxrXJtwg1Ot3mCpgi23XFt4gVE34oYI2bQ+pcVyFtwi183cjaVO2UzqXrwtN8JEC15ynVBPn8lWh+hl8pMBV5ynL2rl8VViOg48UuKLzRjOEPSw89nDcXsMq+EiBs/vgvuF3Cu3DglkEnylstce9dGW6j3gcXdmHTmFm7FPpMfhQQbP7oB9dy93CH+2/R5VRP3dnmR1y6VrtFu7sJqoi7scaeyGavWO1W5hNL8TtOOaTurCbqBwn7YowG19eoEujlpNoU73f8dsa/fyer+Kt/7cYttp4f0n0X+ovPL9/6RS+c/MQZrv10ugy9oyH8NxxuqnHkef4uLhRmHAI0w9h+iFMP4TphzD9/gAYrjykfbvuxgAAAABJRU5ErkJggg=='

         visit new_book_path

         fill_in "book[title]", with: "The Wizard of Oz"
         fill_in "book[authors]", with: "L. Frank Baum"
         fill_in "book[pages]", with: 100
         fill_in "book[year_published]", with: 1900

         click_button 'Create Book'

         expect(page).to have_css("img[src*='#{default_image}']")
       end

       it "should accept multiple authors" do
         visit new_book_path

         fill_in "book[title]", with: "The Wizard of Oz"
         fill_in "book[authors]", with: "L. Frank Baum, SCOTT thomas"
         fill_in "book[pages]", with: 100
         fill_in "book[year_published]", with: 1900
         fill_in "book[image_url]", with: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg"

         click_button 'Create Book'

         expect(page).to have_content("L. Frank Baum")
         expect(page).to have_content("Scott Thomas")
       end

       xit "should not create a duplicate author" do
         author_1 = Author.create("L. Frank Baum")
         book_1 = Book.create(authors: author_1, title: 'googley goo', pages: 200, year_published: 2003)

         visit new_book_path

         fill_in "book[title]", with: "The Wizard of Oz"
         fill_in "book[authors]", with: "L. Frank Baum, SCOTT thomas"
         fill_in "book[pages]", with: 100
         fill_in "book[year_published]", with: 1900
         fill_in "book[image_url]", with: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg"

         click_button 'Create Book'
       end

     it "should not create a duplicate book" do
       author_1 = Author.create(name: "L. Frank Baum")
       book_1 = Book.create(authors: [author_1], title: 'The Wizard of Oz', pages: 200, year_published: 2003)

       visit new_book_path

       fill_in "book[title]", with: "The Wizard of Oz"
       fill_in "book[authors]", with: "L. Frank Baum, SCOTT thomas"
       fill_in "book[pages]", with: 100
       fill_in "book[year_published]", with: 1900
       fill_in "book[image_url]", with: "https://images-na.ssl-images-amazon.com/images/I/81lAPl9Fl0L.jpg"

       click_button 'Create Book'

       expect(page).to have_button('Create Book')
       expect(page).to have_field("book[title]")
      end
    end
  end
end
