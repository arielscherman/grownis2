class CreateDepotDailyBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :depot_daily_balances, id: :uuid do |t|
      t.date :date, null: false
      t.references :depot, type: :uuid, null: false, foreign_key: true
      t.float :cached_rate_value
      t.references :previous_daily_balance, type: :uuid, foreign_key: { to_table: :depot_daily_balances }
      t.integer :cached_depot_total_in_cents
      t.integer :cached_depot_total_by_rate_in_cents
      t.integer :cached_difference_in_cents
      t.integer :cached_difference_by_rate_in_cents
      t.float :cached_difference_in_percentage
      t.float :cached_difference_by_rate_in_percentage

      t.timestamps
    end
  end
end
