class CreateRateValues < ActiveRecord::Migration[6.0]
  def change
    create_table :rate_values do |t|
      t.references :currency, null: false, foreign_key: true
      t.references :rate, null: false, foreign_key: true
      t.decimal :value, precision: 15, scale: 7

      t.timestamps
    end
  end
end
