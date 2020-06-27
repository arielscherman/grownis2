class Depot::TotalsInUsd
  attr_reader :total_in_cents, :difference_in_cents

  def initialize
    @total_in_cents      = 0
    @difference_in_cents = 0.0
  end

  def add(depot)
    return unless depot.latest_daily_balance_id
    if depot.currency.usd?
      @total_in_cents      += depot.latest_daily_balance.cached_depot_total_in_cents
      @difference_in_cents += depot.latest_daily_balance.cached_difference_in_cents
    elsif depot.rate&.to_currency&.usd?
      @total_in_cents      += depot.latest_daily_balance.cached_depot_total_by_rate_in_cents
      @difference_in_cents += depot.latest_daily_balance.cached_difference_by_rate_in_cents
    end
  end
end
