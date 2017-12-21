class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.string :email, null: false
      t.integer :phone, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
