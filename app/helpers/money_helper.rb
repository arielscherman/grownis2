module MoneyHelper
  def display_amount(amount_in_cents)
    display_raw_amount(amount_in_cents / 100.0)
  end

  def display_raw_amount(raw_amount)
    number_to_currency(raw_amount, unit: "").strip
  end

  def display_amount_for_chart(amount_in_cents)
    "#{sprintf("%.2f", amount_in_cents / 100.0)}"
  end

  def display_percentage(number)
    "#{sprintf("%.2f", number)}%"
  end

  def display_amount_with_symbol(amount_in_cents, symbol)
    "#{display_amount(amount_in_cents)} #{symbol}"
  end

  def display_raw_amount_with_symbol(amount, symbol)
    "#{display_raw_amount(amount)} #{symbol}"
  end

  def css_color_for(number)
    number >= 0 ? "text-green" : "text-red"
  end
end
