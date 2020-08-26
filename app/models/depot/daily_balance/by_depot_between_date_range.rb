class Depot::DailyBalance::ByDepotBetweenDateRange
  attr_reader :start_date, :end_date

  def initialize(user, start_date, end_date)
    @user       = user
    @start_date = start_date
    @end_date   = end_date
  end

  def balances_by_depot
    @user.depots.active.map do |depot|
      fetch_balance(depot)
    end
  end

  private

  def fetch_balance(depot)
    starting_depot_balance = starting_balance(depot)
    ending_depot_balance   = ending_balance(depot)
    before_balance         = starting_depot_balance&.cached_depot_total_by_rate_in_cents || 0
    after_balance          = ending_depot_balance&.cached_depot_total_by_rate_in_cents || 0

    {
      id:               depot.id,
      name:             depot.name,
      starting_balance: before_balance,
      ending_balance:   after_balance,
      difference:       after_balance - before_balance,
    }
  end

  def starting_balance(depot)
    depot.daily_balances.find_by(date: @start_date) || earliest_balance_for_depot(depot)
  end

  def ending_balance(depot)
    depot.daily_balances.find_by(date: @end_date) || latest_balance_for_depot(depot)
  end

  def earliest_balance_for_depot(depot)
    depot.daily_balances.find_by(date: earliest_balance_date_for_depot(depot))
  end

  def latest_balance_for_depot(depot)
    depot.daily_balances.find_by(date: latest_balance_date_for_depot(depot))
  end

  def earliest_balance_date_for_depot(depot)
    depot.daily_balances.minimum(:date)
  end

  def latest_balance_date_for_depot(depot)
    depot.daily_balances.maximum(:date)
  end
end
