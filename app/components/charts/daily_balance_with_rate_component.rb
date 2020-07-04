class Charts::DailyBalanceWithRateComponent < Charts::DailyBalanceComponent
  def series
    super.push({ name: title_rate,
                 data: formatted_data.map { |daily_data| daily_data[:total_by_rate] } })
  end

  def title_rate
    @title_rate ||= "Equivalente en #{rate_symbol}"
  end

  private

  def format_daily_data(daily_data)
    super(daily_data).merge(total_by_rate: helpers.display_amount_with_symbol(daily_data.last, rate_symbol))
  end

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

  def rate_symbol
    @rate_symbol ||= @depot.rate.to_currency.symbol
  end
end
