class RemoveBookAuthorFromAuthors < ActiveRecord::Migration[5.1]
  def change
    remove_column :authors, :book_author_id
  end
end
