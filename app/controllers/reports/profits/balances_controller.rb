class Reports::Profits::BalancesController < ApplicationController
  layout false

  def show
    consolidated = Depot::DailyBalance::ConsolidatedBetweenDateRange.new(current_user, start_date, end_date)
    render :show, locals: { consolidated: consolidated, start_date: start_date, end_date: end_date, placeholder_id: placeholder_id }
  end

  private

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end

  
  def start_date
    @start_date ||= Date.parse(params.require(:start_date))
  end

  def end_date
    @end_date ||= Date.parse(params.require(:end_date))
  end
end
