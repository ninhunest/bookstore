class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.string :email, null: false, default: ""
      t.timestamps
    end
  end
end
