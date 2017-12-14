class LineItem < ApplicationRecord
  belongs_to :book, foreign_key: :item_id
  # belongs_to :cart
  acts_as_shopping_cart_item_for :cart
end
