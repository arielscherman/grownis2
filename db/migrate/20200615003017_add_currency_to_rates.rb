class AddCurrencyToRates < ActiveRecord::Migration[6.0]
  def change
    add_reference :rates, :currency, type: :uuid, null: false, foreign_key: true
  end
end
