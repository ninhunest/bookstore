class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :name, :address, :email, :phone,  :presence => true
end
