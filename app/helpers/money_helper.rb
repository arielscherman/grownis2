module MoneyHelper
  def display_amount(amount_in_cents)
    sprintf("%.2f", amount_in_cents / 100.0)
  end

  def display_amount_with_symbol(amount_in_cents, symbol)
    "#{symbol} #{display_amount(amount_in_cents)}"
  end
end
