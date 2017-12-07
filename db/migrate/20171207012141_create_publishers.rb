class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :email, null: false, default: ""
      t.integer :phone, null: false
      t.timestamps
    end
  end
end
