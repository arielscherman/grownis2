class Depot::DailyBalance::ConsolidatedByDate
  def initialize
    @result = Hash.new(0)
  end

  def add(daily_balance)
    @result[daily_balance.date] += daily_balance.cents_in_usd
  end

  def result
    @result.sort
  end
end
