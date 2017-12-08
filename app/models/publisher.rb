class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :select_fields, ->{select :id, :name}

  class << self
    def hot_publishers
      publisher_ids = Publisher.joins(:books).order("count_books_id DESC")
        .group(:id).limit(Settings.hot_items.limit).count("books.id").keys
      Publisher.select_fields.find publisher_ids
    end
  end

  scope :attributes_select_publisher, (lambda do
    select :id, :name
  end)
end
