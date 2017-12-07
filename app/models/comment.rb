class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :book, presence: true
  validates :user, presence: true
end
