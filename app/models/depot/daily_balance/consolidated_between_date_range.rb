class Depot::DailyBalance::ConsolidatedBetweenDateRange
  attr_reader :start_date, :end_date

  def initialize(user, start_date, end_date)
    @result     = Hash.new(0)
    @user       = user
    @start_date = start_date
    @end_date   = end_date

    # fetch balances to override dates if not found with given
    starting_balances
    ending_balances
  end

  def difference_in_days
    (end_date - start_date).to_i
  end

  def difference_in_usd
    end_balance_in_usd - start_balance_in_usd
  end

  def start_balance_in_usd
    starting_balances.reduce(0) { |total, balance| total += balance.cents_in_usd }
  end

  def end_balance_in_usd
    ending_balances.reduce(0) { |total, balance| total += balance.cents_in_usd }
  end

  private

  def daily_balances_by_date
    @daily_balances_by_date ||= user_balances.where(date: [@start_date, @end_date]).group_by(&:date)
  end

  def user_balances
    ::Depot::DailyBalance.includes(depot: [:currency, :user]).where(depots: { users: { id: @user.id }})
  end

  def starting_balances
    @starting_balances ||= if daily_balances_by_date[@start_date]
      daily_balances_by_date[@start_date]
    else
      # no balances for given date, then using earliest.
      @start_date = earliest_date
      earliest_balances
    end
  end

  def ending_balances
    @ending_balances ||= if daily_balances_by_date[@end_date]
      daily_balances_by_date[@end_date]
    else
      # no balances for given date, then using latest.
      @end_date = latest_date
      latest_balances
    end
  end

  def earliest_balances
    user_balances.where(date: earliest_date)
  end
  
  def latest_balances
    user_balances.where(date: latest_date)
  end

  def earliest_date
    @earliest_date ||= user_balances.minimum(:date)
  end

  def latest_date
    @latest_date ||= user_balances.maximum(:date)
  end
end
