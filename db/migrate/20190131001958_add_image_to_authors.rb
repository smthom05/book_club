class AddImageToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :image_url, :string
  end
end
