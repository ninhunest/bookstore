class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy, foreign_key: :owner_id
  acts_as_shopping_cart_using :line_item

end
