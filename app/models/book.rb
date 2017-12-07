class Book < ApplicationRecord
  belongs_to :category
  belongs_to :publisher
  has_many :comments, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :line_items, dependent: :destroy
  has_many :rates, dependent: :destroy

  scope :price_from, ->price {where("price >= ?", price)}
  scope :price_to, ->price {where("price <= ?", price)}
  scope :except_current_book, ->book {where("id != ?", book.id)}
  scope :where_in, ->ids {where("id IN (?)", ids)}
  scope :find_by_title, ->title {where("title LIKE ?", "%" + title + "%")}

  scope :select_fields, (lambda do
    select :id, :title, :image_url, :price, :discount, :created_at, :updated_at,
      :category_id
  end)
end
