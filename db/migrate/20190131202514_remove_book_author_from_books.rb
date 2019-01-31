class RemoveBookAuthorFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :book_author_id
  end
end
