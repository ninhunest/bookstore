class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  before_create :set_order_status
  before_save :update_subtotal
end
