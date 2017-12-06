class Book < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :line_items, dependent: :destroy
  has_many :rates, dependent: :destroy
  validates :category, presence: true
  validates :title, presence: true,
    length: {maximum: Settings.max_length_title_book}
  validates :description, presence: true
  validates :price, presence: true
end
