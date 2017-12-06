class CreateBooksVieweds < ActiveRecord::Migration[5.1]
  def change
    create_table :books_vieweds do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
