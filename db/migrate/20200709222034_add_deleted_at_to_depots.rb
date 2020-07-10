class AddDeletedAtToDepots < ActiveRecord::Migration[6.0]
  def change
    add_column :depots, :deleted_at, :datetime
    add_index :depots, :deleted_at
  end
end
