class AddCartIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :cart, foreign_key: true
  end
end
