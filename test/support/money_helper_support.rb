module MoneyHelperSupport
  def amount(amount_in_cents)
    sprintf("%.2f", amount_in_cents / 100.0)
  end

  def percentage(number)
    "#{sprintf("%.2f", number)}%"
  end

  def amount_with_currency(amount_in_cents, currency_symbol)
    "#{amount(amount_in_cents)} #{currency_symbol}"
  end
end
