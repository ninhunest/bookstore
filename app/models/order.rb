class Order < ApplicationRecord
  belongs_to :cart

  enum status: [:pending, :done]

  scope :attributes_select_order, (lambda do
    select :id, :name, :address, :email, :phone, :status, :created_at
  end)
end
