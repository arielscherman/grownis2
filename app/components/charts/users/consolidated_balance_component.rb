class Charts::Users::ConsolidatedBalanceComponent < ViewComponent::Base
  def initialize(daily_balances)
    @daily_balances = daily_balances
  end

  def json_categories
    formatted_data.map { |daily_data| daily_data[:date] }.to_json
  end

  def json_series
    [{ name: "Total en USD",
       data: formatted_data.map { |daily_data| daily_data[:total] } }].to_json
  end

  private

  def data
    @data ||= @daily_balances.consolidated_by_date
  end

  def formatted_data
    @formatted_data ||= data.map { |date, amount_in_cents| format_daily_data(date, amount_in_cents) }
  end

  def format_daily_data(date, amount_in_cents)
    { date:  I18n.l(date, format: :short),
      total: helpers.display_amount_with_symbol(amount_in_cents, "USD") }
  end
end
