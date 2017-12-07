class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  enum role: [:guest, :admin]
  enum sex: [:male, :female]
end
