class Depots::MovementsController < ApplicationController
  before_action :authenticate_user!

  helper_method :depot, :movements

  def index; end

  private

  def depot
    @depot ||= Depot.includes(:currency).references(:currency).where(user_id: current_user.id).active.find(depot_id)
  end

  def depot_id
    @depot_id ||= params.require(:depot_id)
  end

  def movements
    @movements ||= depot.movements.order(date: :desc, id: :desc)
  end
end
