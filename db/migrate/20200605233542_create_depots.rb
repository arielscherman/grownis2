class CreateDepots < ActiveRecord::Migration[6.0]
  def change
    create_table :depots, id: :uuid do |t|
      t.string :name, null: false
      t.bigint :cached_total_cents, default: 0, null: false
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
