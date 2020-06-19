class CreateRateValues < ActiveRecord::Migration[6.0]
  def change
    create_table :rate_values do |t|
      t.references :rate, null: false, foreign_key: true
      t.float :value, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
