class Depot::Consolidated
  attr_reader :in_cents, :difference_in_cents

  def initialize
    @in_cents            = 0
    @difference_in_cents = 0
  end

  def add(depot)
    return unless depot.latest_daily_balance_id
    @in_cents            += depot.latest_daily_balance.cents_in_usd
    @difference_in_cents += depot.latest_daily_balance.difference_cents_in_usd
  end
end
