class Charts::Users::ConsolidatedBalancesController < ApplicationController
  layout false

  # this is not the limit of dates but the limit of daily balances
  # it's a big number to prevent fetching thousands, but it will limit the display in the UI anyway.
  LIMIT = 200.freeze

  def show
    render :show, locals: { daily_balances: Depot::DailyBalance.for_user(current_user).order(date: :desc).limit(LIMIT), placeholder_id: placeholder_id }
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end
end
