class Charts::DailyBalancesController < ApplicationController
  layout false

  LIMIT = 30.freeze

  helper_method :placeholder_id

  def index
    @depot          = Depot.find(params.require(:depot_id))
    @daily_balances = @depot.daily_balances.limit(LIMIT).order(:date)
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end
end
