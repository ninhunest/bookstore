class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, :address, :email, :phone,  :presence => true
end
