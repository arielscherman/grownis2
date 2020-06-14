Currency.create([
  { name: "Dolar", symbol: "USD" },
  { name: "Peso Argentino", symbol: "ARS" }
])

Rate.create!([
  { name: "Dolar Blue", key: "dolar_blue" },
  { name: "Dolar CCL", key: "dolar_ccl" },
  { name: "Dolar MEP", key: "dolar_mep" },
])
