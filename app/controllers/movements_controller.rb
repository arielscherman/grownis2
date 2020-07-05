class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, locals: { movements: movements }
  end

  private

  def movements
    @movements ||= Depot::Movement.includes(depot: :currency).where(depots: { user_id: current_user.id }).order(date: :desc, id: :desc)
  end
end
