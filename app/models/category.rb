class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :select_fields, ->{select :id, :name}

  class << self
    def hot_categories
      category_ids = Category.joins(:books).order("count_books_id DESC")
        .group(:id).limit(Settings.hot_items.limit).count("books.id").keys
      Category.select_fields.find category_ids
    end
  end
end
