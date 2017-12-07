class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :image_url
      t.decimal :price, :precision => 8, null: false
      t.decimal :p_price, :precision => 8
      t.integer :view
      t.references :publisher, foreign_key: true
      t.references :author, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
