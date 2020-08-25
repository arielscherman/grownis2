class Charts::Users::ConsolidatedBalancesController < ApplicationController
  layout false

  # this is not the limit of dates but the limit of daily balances
  # it's a big number to prevent fetching thousands, but it will limit the display in the UI anyway.
  LIMIT = 200.freeze

  def show
    render :show, locals: { daily_balances: Depot::DailyBalance.for_user(current_user).between_dates(start_date, end_date).order(date: :desc).limit(LIMIT), chart_type: params[:chart_type], placeholder_id: placeholder_id }
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end

  private

  def start_date
    @start_date ||= params[:start_date] ? Date.parse(params[:start_date]) : nil
  end

  def end_date
    @end_date ||= params[:end_date] ? Date.parse(params[:end_date]) : nil
  end
end
