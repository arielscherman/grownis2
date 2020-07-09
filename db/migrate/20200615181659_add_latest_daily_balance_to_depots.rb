class AddLatestDailyBalanceToDepots < ActiveRecord::Migration[6.0]
  def change
    add_reference :depots, :latest_daily_balance, type: :uuid, foreign_key: { to_table: :depot_daily_balances }
  end
end
