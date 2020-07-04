usd = Currency.create!(name: "Dolar", symbol: "USD")
ars = Currency.create!(name: "Peso Argentino", symbol: "ARS")

Rate.create!([
  { name: "Dolar Blue", key: "ars_in_dolar_blue", currency: ars, to_currency: usd },
  { name: "Dolar CCL", key: "ars_in_dolar_ccl", currency: ars, to_currency: usd },
  { name: "Dolar MEP", key: "ars_in_dolar_mep", currency: ars, to_currency: usd },
])
