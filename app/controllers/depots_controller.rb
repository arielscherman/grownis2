class DepotsController < ApplicationController
  before_action :authenticate_user!

  def index
    fail "temporal error in depots"
    @consolidated = depots.consolidated
    render :index, locals: { depots: depots }
  end

  def new
    @depot = Depot.new

    render :new, locals: { depot: @depot, rates: [], currency_categories: categories }
  end

  def create
    @depot = Depot.new(depot_params.merge(user: current_user))
    @depot.save

    rates = Rate.where(currency_id: depot_params[:currency_id])

    render :create, locals: { depot: @depot, rates: rates, currency_categories: categories }
  end

  def edit
    render :edit, locals: { depot: depot, rates: depot.currency.rates, currency_categories: categories }
  end

  def update
    depot.update(depot_params)

    render :update, locals: { depot: depot, rates: depot.currency.rates, currency_categories: categories }
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

  def categories
    @categories ||= Currency::Category.includes(:currencies).all
  end
end
