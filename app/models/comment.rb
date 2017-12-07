class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, foreign_key: "parent_id", dependent: :destroy

  scope :select_fields, (lambda do
    select :id, :content, :user_id, :book_id, :parent_id, :created_at
  end)

  scope :load_comment, ->book {where "book_id = ?", book.id}
  scope :except_reply, ->{where "parent_id IS ?", nil}
  scope :reply, ->comment {where "parent_id = ?", comment.id}
end
