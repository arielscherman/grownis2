class AddDolarOficialRate < ActiveRecord::Migration[6.0]
  def change
    rate_class = Class.new(ApplicationRecord) do
      self.table_name = "rates"
    end

    currency_class = Class.new(ApplicationRecord) do
      self.table_name = "currencies"
    end

    ars = currency_class.find_by(symbol: "ARS")
    usd = currency_class.find_by(symbol: "USD")

    rate_class.find_or_create_by!(name: "Dolar Oficial", key: "ars_in_dolar_oficial", currency_id: ars.id, to_currency_id: usd.id, measured_in_currency: true)
  end
end
