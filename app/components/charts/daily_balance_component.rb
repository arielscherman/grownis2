class Charts::DailyBalanceComponent < ViewComponent::Base
  def initialize(depot, daily_balances)
    @depot          = depot
    @daily_balances = daily_balances
  end

  def json_categories
    formatted_data.map { |daily_data| daily_data[:date] }.to_json
  end

  def json_series
    series.to_json
  end

  def title_currency
    @title_currency ||= "Balance en #{currency_symbol}"
  end

  private

  def series
    [{ name: title_currency,
       data: formatted_data.map { |daily_data| daily_data[:total] } }]
  end

  def data
    @data ||= @daily_balances.pluck(:date, :cached_depot_total_in_cents)
  end

  def formatted_data
    @formatted_data ||= data.map { |daily_data| format_daily_data(daily_data) }
  end

  def format_daily_data(daily_data)
    { date:  I18n.l(daily_data.first, format: :short),
      total: helpers.display_amount_with_symbol(daily_data.second, currency_symbol) }
  end

  def currency_symbol
    @currency_symbol ||= @depot.currency.symbol
  end
end
