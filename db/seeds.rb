crypto = Currency::Category.create!(name: "Crypto")
currency = Currency::Category.create!(name: "Moneda")

usd = Currency.find_or_create_by(name: "Dolar", symbol: "USD", category: currency)
ars = Currency.find_or_create_by(name: "Peso Argentino", symbol: "ARS", category: currency)
btc = Currency.find_or_create_by(name: "Bitcoin", symbol: "BTC", category: crypto)
eth = Currency.find_or_create_by(name: "Ethereum", symbol: "ETH", category: crypto)

Rate.create!([
  { name: "Dolar Blue", key: "ars_in_dolar_blue", currency: ars, to_currency: usd, measured_in_currency: true },
  { name: "Dolar Oficial", key: "ars_in_dolar_oficial", currency: ars, to_currency: usd, measured_in_currency: true },
  { name: "Dolar CCL", key: "ars_in_dolar_ccl", currency: ars, to_currency: usd, measured_in_currency: true },
  { name: "Dolar MEP", key: "ars_in_dolar_mep", currency: ars, to_currency: usd, measured_in_currency: true },
  { name: "Bitcoin", key: "btc_in_usd", currency: btc, to_currency: usd, measured_in_currency: false },
  { name: "Ethereum", key: "eth_in_usd", currency: eth, to_currency: usd, measured_in_currency: false },
])
