class Author < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :books, through: :book_authors
  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_author}
end
