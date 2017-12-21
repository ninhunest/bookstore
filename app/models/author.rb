class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors
  scope :select_fields, ->{select :id, :name}

  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_author}

  class << self
    def hot_authors
      author_ids = Author.joins(:book_authors)
        .order("count_book_authors_book_id DESC")
        .group("book_authors.author_id").limit(Settings.hot_items.limit)
        .count("book_authors.book_id").keys
      Author.select_fields.find author_ids
    end
  end
  scope :author_attributes_select, (lambda do
    select :id, :name, :created_at, :updated_at
  end)
end
