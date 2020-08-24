class Rate::ValuesBetweenDateRange
  attr_reader :start_date, :end_date

  def initialize(user, start_date, end_date)
    @result     = Hash.new(0)
    @user       = user
    @start_date = start_date
    @end_date   = end_date
  end

  def prices
    Rate.includes(:depots, :values).where(depots: { user: @user }).map do |rate|
      fetch_prices(rate)
    end
  end

  private

  def fetch_prices(rate)
    starting_rate_value = starting_price(rate)
    ending_rate_value = ending_price(rate)

    {
      id:             rate.id,
      name:           rate.name,
      starting_price: starting_rate_value.informative_value,
      ending_price:   ending_rate_value.informative_value,
      difference:     ending_rate_value.informative_value - starting_rate_value.informative_value,
      start_date:     starting_rate_value.date,
      end_date:       ending_rate_value.date,
      value_symbol:   ending_rate_value.rate.informative_currency.symbol
    }
  end

  def starting_price(rate)
    rate.values.find_by(date: @start_date) || earliest_rate_value(rate)
  end

  def ending_price(rate)
    rate.values.find_by(date: @end_date) || latest_rate_value(rate)
  end

  def earliest_rate_value(rate)
    rate.values.find_by(date: earliest_rate_value_date(rate))
  end

  def latest_rate_value(rate)
    rate.values.find_by(date: latest_rate_value_date(rate))
  end

  def earliest_rate_value_date(rate)
    rate.values.minimum(:date)
  end

  def latest_rate_value_date(rate)
    rate.values.maximum(:date)
  end
end
