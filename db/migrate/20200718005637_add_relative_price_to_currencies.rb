class AddRelativePriceToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :measured_in_currency, :boolean, default: false
  end
end
