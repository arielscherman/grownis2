module MoneyHelperSupport
  include ActionView::Helpers::NumberHelper

  def amount(amount_in_cents)
    raw_amount(amount_in_cents / 100.0)
  end

  def raw_amount(raw_amount)
    number_to_currency(raw_amount, unit: "").strip
  end

  def percentage(number)
    "#{sprintf("%.2f", number)}%"
  end

  def amount_with_currency(amount_in_cents, currency_symbol)
    "#{amount(amount_in_cents)} #{currency_symbol}"
  end

  def raw_amount_with_currency(raw_amount, currency_symbol)
    "#{raw_amount(raw_amount)} #{currency_symbol}"
  end

  def amount_for_chart(amount_in_cents)
    "#{sprintf("%.2f", amount_in_cents / 100.0)}"
  end
end
