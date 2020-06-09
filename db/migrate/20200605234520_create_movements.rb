class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :depot_movements do |t|
      t.references :depot, null: false, foreign_key: true
      t.bigint :total_cents
      t.date :date, null: false

      t.timestamps
    end
    add_index :depot_movements, :date
  end
end
