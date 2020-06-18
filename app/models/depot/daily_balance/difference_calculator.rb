class Depot::DailyBalance::DifferenceCalculator < Depot::DailyBalance::Calculator
  def initialize(previous_balance, balance)
    @balance          = balance
    @previous_balance = previous_balance
  end

  def in_percentage
    return 0.0 if @previous_balance.nil?
    variation_between(previous_balance_in_cents, balance_in_cents)
  end

  def in_cents
    return 0 if @previous_balance.nil?
    balance_in_cents - previous_balance_in_cents
  end

  private

  def balance_in_cents
    @balance_in_cents ||= @balance.cached_depot_total_in_cents
  end

  def previous_balance_in_cents
    @previous_balance_in_cents ||= @previous_balance.cached_depot_total_in_cents
  end
end
