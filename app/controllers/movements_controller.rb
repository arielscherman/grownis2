class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, locals: { movements: movements, depots: depots }
  end

  def new
    render :new, locals: { movement: Depot::Movement.new, depot_id: depot_id }
  end

  def create
    @movement = Depot::Movement.new({ depot_id: depot_id }.merge(movement_params))
    @movement.save

    render :create, locals: { movement: @movement, depot_id: depot_id, url: movements_path, movements: depot_id.present? ? depot_movements : movements }
  end

  private

  def depot_movements
    @depot_movements ||= Depot::Movement.where(depot_id: depot_id).order(date: :desc, id: :desc)
  end

  def movements
    @movements ||= Depot::Movement.includes(depot: :currency).where(depots: { user_id: current_user.id }).order(date: :desc, id: :desc)
  end

  def movement_params
    params.require(:depot_movement).permit(:depot_id, :total, :date, :description)
  end

  def depots
    @depots ||= Depot.where(user: current_user)
  end

  def depot_id
    @depot_id ||= params.permit(:depot_id)[:depot_id]
  end
end
