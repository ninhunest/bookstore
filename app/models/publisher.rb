class Publisher < ApplicationRecord
  acts_as_paranoid
  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_publisher}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :phone, presence: true
  scope :select_fields, ->{select :id, :name}
  class << self
    def hot_publishers
      publisher_ids = Publisher.joins(:books).order("count_books_id DESC")
        .group(:id).limit(Settings.hot_items.limit).count("books.id").keys
      Publisher.select_fields.find publisher_ids
    end
  end

  scope :attributes_select_publisher, (lambda do
    select :id, :name, :address, :email, :phone, :created_at
  end)
end
