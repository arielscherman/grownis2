class Charts::Users::ConsolidatedBalancesController < ApplicationController
  layout false

  LIMIT = 20.freeze

  helper_method :placeholder_id

  def show
    @daily_balances = Depot::DailyBalance.joins(depot: :user).where(depots: { user_id: current_user.id }).order(date: :desc).limit(LIMIT)
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end
end
