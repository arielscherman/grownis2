class Charts::RateComponent < ViewComponent::Base
  def initialize(rate, rate_values)
    @rate        = rate
    @rate_values = rate_values
  end

  def series
    [{ name: "En #{@rate.informative_currency.symbol}",
       data: formatted_data.map { |value| value[:price] } }]
  end

  def json_series
    series.to_json
  end

  def json_categories
    formatted_data.map { |value| value[:date] }.to_json
  end

  private

  def formatted_data
    @formatted_data ||= @rate_values.map { |rate_value| format_daily_data(rate_value) }
  end

  def format_daily_data(rate_value)
    { date:  I18n.l(rate_value.date, format: :short),
      price: rate_value.informative_value }
  end
end
