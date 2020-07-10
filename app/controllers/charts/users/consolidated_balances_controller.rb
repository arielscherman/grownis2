class Charts::Users::ConsolidatedBalancesController < ApplicationController
  layout false

  LIMIT = 20.freeze

  def show
    render :show, locals: { daily_balances: Depot::DailyBalance.for_user(current_user).order(date: :desc).limit(LIMIT), placeholder_id: placeholder_id }
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end
end
