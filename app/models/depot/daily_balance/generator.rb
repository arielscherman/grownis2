class Depot::DailyBalance::Generator
  def generate!
    Rate.find_each { |rate| daily_rate_values[rate.id] = rate.fetch_daily_value!(market).value }

    Depot.active.includes(:latest_daily_balance).find_each do |depot|
      latest_balance = depot.latest_daily_balance

      created_balance = Depot::DailyBalance.find_or_create_by!(depot: depot, date: Time.zone.today) do |daily_balance|
        daily_balance.previous_daily_balance      = latest_balance
        daily_balance.cached_rate_value           = daily_rate_values[depot.rate_id]
        daily_balance.cached_depot_total_in_cents = depot.cached_total_cents
      end

      depot.update!(latest_daily_balance: created_balance)
    end
  end

  private

  def market
    @market ||= Rate::Value::Market.new
  end

  def daily_rate_values
    @daily_rate_values ||= {}
  end
end
