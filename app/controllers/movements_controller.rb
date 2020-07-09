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

    if depot_id.present?
      render "depots/movements/create.js.erb", locals: { movement: @movement, depot: depot, movements: depot_movements }
    else
      render :create, locals: { movement: @movement, depot_id: depot_id, movements:  movements }
    end
  end

  def destroy
    @movement = Depot::Movement.find(movement_id)
    @movement.destroy

    if depot_id.present?
      render "depots/movements/destroy.js.erb", locals: { movement: @movement, depot: depot }
    else
      render :destroy, locals: { movement: @movement }
    end
  end

  private

  def depot_movements
    @depot_movements ||= movements.where(depot_id: depot_id)
  end

  def movements
    @movements ||= Depot::Movement.includes(depot: :currency).where(depots: { user_id: current_user.id }).order(date: :desc, id: :desc)
  end

  def movement_id
    @movement_id ||= params.require(:id)
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

  def depot
    @depot ||= Depot.find(depot_id)
  end
end
