class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :depot_movements, id: :uuid do |t|
      t.references :depot, type: :uuid, null: false, foreign_key: true
      t.bigint :total_cents
      t.date :date, null: false

      t.timestamps
    end
    add_index :depot_movements, :date
  end
end
