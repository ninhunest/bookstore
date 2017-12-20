class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :address
      t.string :email
      t.integer :phone
      t.timestamps
    end
  end
end
