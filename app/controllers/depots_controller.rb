class DepotsController < ApplicationController
  before_action :authenticate_user!

  helper_method :depot, :currencies, :depots, :rates

  def index
    @consolidated = depots.consolidated
  end

  def new
    @depot = Depot.new
  end

  def create
    @depot = Depot.new(depot_params.merge(user: current_user))
    @depot.save
  end

  def update
    depot.update(depot_params)
  end

  def show
    render :show, locals: { depot: depot }
  end

  def destroy
    depot.soft_delete!

    render :destroy, locals: { depot: depot }
  end

  private

  def depots
    @depots ||= current_user.depots.active.includes(:currency, :latest_daily_balance).order(created_at: :desc)
  end

  def depot_params
    params.require(:depot).permit(:name, :currency_id, :rate_id)
  end

  def depot
    @depot ||= Depot.active.find(params.require(:id))
  end

  def currencies
    @currencies ||= Currency.all
  end

  def rates
    @rates ||= Rate.all
  end
end
