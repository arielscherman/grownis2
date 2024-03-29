class Depot::DailyBalance::DifferenceByRateCalculator < Depot::DailyBalance::Calculator
  def initialize(previous_balance, balance, rate_value)
    @balance          = balance
    @previous_balance = previous_balance
    @rate_value       = rate_value
  end

  def in_percentage
    return if @rate_value.nil?
    return 0.0 if @previous_balance.nil?
    variation_between(previous_converted_balance, converted_balance)
  end

  def in_cents
    return if @rate_value.nil?
    return convert(@balance.cached_depot_total_in_cents).to_i if @previous_balance.nil?
    (convert(@previous_balance.cached_depot_total_in_cents) - previous_converted_balance).to_i
  end

  def convert(value)
    return if @rate_value.nil?
    value * @rate_value
  end

  private

  def previous_converted_balance
    @previous_converted_balance ||= @previous_balance.cached_depot_total_by_rate_in_cents 
  end

  def converted_balance
    @converted_balance ||= @balance.cached_depot_total_by_rate_in_cents 
  end
end
