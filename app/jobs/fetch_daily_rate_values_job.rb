class FetchDailyRateValuesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    market = Rate::Value::Market.new
    Rate.find_each { |rate| rate.fetch_daily_value(market) }
  end
end
