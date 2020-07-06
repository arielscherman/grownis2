class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, locals: { movements: movements, depots: depots }
  end

  def new
    render :new, locals: { movement: Depot::Movement.new }
  end

  def create
    @movement = Depot::Movement.new(movement_params)
    @movement.save

    render :create, locals: { movement: @movement, depot: nil, url: movements_path, movements: movements }
  end

  private

  def movements
    @movements ||= Depot::Movement.includes(depot: :currency).where(depots: { user_id: current_user.id }).order(date: :desc, id: :desc)
  end

  def movement_params
    params.require(:depot_movement).permit(:depot_id, :total, :date, :description)
  end

  def depots
    @depots ||= Depot.where(user: current_user)
  end
end
