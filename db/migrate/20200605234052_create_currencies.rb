class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :symbol, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :currencies, :name, unique: true
    add_index :currencies, :symbol, unique: true

    add_reference :depots, :currency, null: false, foreign_key: true
  end
end
