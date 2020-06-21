class Chart::DailyBalance
  LIMIT = 15.freeze

  def initialize(depot)
    @depot = depot
  end

  def categories
    daily_balances_data.map(&:first)
  end

  def series
    [{
      name: "Balance en #{@depot.currency.symbol}",
      data: daily_balances_data.map(&:second)
    }, {
      name: "Equivalente en #{@depot.rate.to_currency.symbol}",
      data: daily_balances_data.map(&:last)
    }]
  end

  def titles
    [{ title: { text: "Balance en #{@depot.currency.symbol}" }},
     { title: { text: "Equivalente en #{@depot.rate.to_currency.symbol}" }, opposite: true }]
  end

  private

  def daily_balances_data
    @daily_balances_data ||= @depot.daily_balances.limit(LIMIT).order(:date).pluck(:date, :cached_depot_total_in_cents, :cached_depot_total_by_rate_in_cents)
  end
end
