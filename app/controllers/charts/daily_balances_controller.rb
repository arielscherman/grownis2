class Charts::DailyBalancesController < ApplicationController
  layout false

  helper_method :placeholder_id

  def index
    @chart = Chart::DailyBalance.new(depot)
  end

  def placeholder_id
    @placeholder_id ||= params.require(:placeholder_id)
  end

  def depot
    @depot ||= Depot.find(params.require(:depot_id))
  end
end
