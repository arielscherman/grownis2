module MoneyHelperSupport
  include ActionView::Helpers::NumberHelper

  def amount(amount_in_cents)
    number_to_currency(amount_in_cents / 100.0, unit: "").strip
  end

  def percentage(number)
    "#{sprintf("%.2f", number)}%"
  end

  def amount_with_currency(amount_in_cents, currency_symbol)
    "#{amount(amount_in_cents)} #{currency_symbol}"
  end
end
