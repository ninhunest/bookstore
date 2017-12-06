class Rate < ApplicationRecord
  belong_to :user
  belong_to :book

  validates :rate, presence: true
  validates :book, presence: true
  validates :user, presence: true
end
