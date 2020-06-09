class Depots::MovementsController < ApplicationController
  before_action :authenticate_user!

  helper_method :currency, :depot, :movement, :movements

  def new
    @movement = Depot::Movement.new
  end

  def create
    @movement = Depot::Movement.new(movement_params.merge(depot_id: depot_id))
    @movement.save
  end

  def destroy
    movement.destroy
  end

  private

  def depot
    @depot ||= Depot.includes(:currency).references(:currency).where(user_id: current_user.id).find(depot_id)
  end

  def depot_id
    @depot_id ||= params.require(:depot_id)
  end

  def currency
    @currency ||= depot.currency
  end

  def movement
    @movement ||= Depot::Movement.find(params.require(:id))
  end

  def movements
    @movements ||= depot.movements.order(date: :desc)
  end

  def movement_params
    params.require(:depot_movement).permit(:total, :date)
  end
end
