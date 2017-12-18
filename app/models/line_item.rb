class LineItem < ApplicationRecord
  belongs_to :book, foreign_key: :item_id
  acts_as_shopping_cart_item_for :cart

  scope :line_items, (lambda do |cart, book|
    where("owner_id = ? AND item_id =?", cart.id, book.id)
  end)
end
