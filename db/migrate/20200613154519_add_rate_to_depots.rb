class AddRateToDepots < ActiveRecord::Migration[6.0]
  def change
    add_reference :depots, :rate, null: false, foreign_key: true
  end
end
