class Charts::DailyBalanceComponent < ViewComponent::Base
  def initialize(depot, daily_balances)
    @depot          = depot
    @daily_balances = daily_balances
  end

  def json_categories
    formatted_data.map { |daily_data| daily_data[:date] }.to_json
  end

  def json_series
    [{
      name: "Balance en #{@depot.currency.symbol}",
      data: formatted_data.map { |daily_data| daily_data[:total] }
    }, {
      name: "Equivalente en #{@depot.rate.to_currency.symbol}",
      data: formatted_data.map { |daily_data| daily_data[:total_by_rate] }
    }].to_json
  end

  def title_currency
    @title1 ||= "Balance en #{currency_symbol}"
  end

  def title_rate
    @title2 ||= "Equivalente en #{rate_symbol}"
  end

  private

  def data
    @data ||= @daily_balances.pluck(:date, :cached_depot_total_in_cents, :cached_depot_total_by_rate_in_cents)
  end

  def formatted_data
    @formatted_data ||= data.map do |daily_data|
      { date:          I18n.l(daily_data.first, format: :short),
        total:         helpers.display_amount_with_symbol(daily_data.second, currency_symbol),
        total_by_rate: helpers.display_amount_with_symbol(daily_data.last, rate_symbol) }
    end
  end

  def currency_symbol
    @currency_symbol ||= @depot.currency.symbol
  end

  def rate_symbol
    @rate_symbol ||= @depot.rate.to_currency.symbol
  end
end
