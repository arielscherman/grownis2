class AddOtherCurrencyToRates < ActiveRecord::Migration[6.0]
  def change
    add_reference :rates, :to_currency, foreign_key: { to_table: :currencies }

    currency_class = Class.new(ApplicationRecord) do
      self.table_name = "currencies"
    end

    rate_class = Class.new(ApplicationRecord) do
      self.table_name = "rates"
    end

    rate_class.update_all(to_currency_id: currency_class.find_or_create_by!(symbol: "USD").id)

    change_column_null :rates, :to_currency_id, false
  end
end
