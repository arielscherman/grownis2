class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies, id: :uuid do |t|
      t.string :symbol, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :currencies, :name, unique: true
    add_index :currencies, :symbol, unique: true

    add_reference :depots, :currency, type: :uuid, null: false, foreign_key: true
  end
end
