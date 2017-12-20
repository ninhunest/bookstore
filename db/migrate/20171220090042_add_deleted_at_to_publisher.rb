class AddDeletedAtToPublisher < ActiveRecord::Migration[5.1]
  def change
    add_column :publishers, :deleted_at, :datetime
    add_index :publishers, :deleted_at
  end
end
