class RemoveBookReferenceFromAuthors < ActiveRecord::Migration[5.1]
  def change
    remove_column :authors, :book_id
  end
end
