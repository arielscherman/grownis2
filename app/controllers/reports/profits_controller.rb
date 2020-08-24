class Reports::ProfitsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, locals: { start_date: 1.month.ago.to_date, end_date: Date.current }
  end

  private

  def first_balance_date
    @first_balance_date ||= current_user.depots.joins(:daily_balances).minimum("depot_daily_balances.date")
  end
end
