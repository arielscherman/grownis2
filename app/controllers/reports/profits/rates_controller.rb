class Reports::Profits::RatesController < ApplicationController
  layout false

  def index
    consolidated_rates = Rate::ValuesBetweenDateRange.new(current_user, start_date, end_date)

    render :index, locals: { consolidated: consolidated_rates.prices, start_date: start_date, end_date: end_date, placeholder_id: placeholder_id }
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
