class AddBookAuthorsToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_reference :authors, :book_author, foreign_key: true
  end
end
