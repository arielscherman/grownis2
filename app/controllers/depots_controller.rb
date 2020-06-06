class DepotsController < ApplicationController
  before_action :authenticate_user!

  helper_method :depot, :currencies

  def index
    @depots = current_user.depots.includes(:currency).order(created_at: :desc)
  end

  def new
    @depot = Depot.new
  end

  def create
    @depot = Depot.new(depot_params.merge(user: current_user))
    @depot.save
  end

  private

  def depot_params
    params.require(:depot).permit(:name, :currency_id)
  end

  def depot
    @depot ||= Depot.find(params.require(:id))
  end

  def currencies
    @currencies ||= Currency.all
  end
end
