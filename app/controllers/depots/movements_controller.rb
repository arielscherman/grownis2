class Depots::MovementsController < ApplicationController
  before_action :authenticate_user!

  helper_method :currency, :depot, :movement, :movements

  def destroy
    @depot_id = movement.depot_id # to be able to fetch all depot's movements later
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
    @movements ||= depot.movements.order(date: :desc, id: :desc)
  end
end
