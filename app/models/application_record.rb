class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :order_by_name, ->{order :name}
end
