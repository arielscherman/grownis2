class Movement::ModalFormComponent < ViewComponent::Base
  def initialize(movement, depot_id, current_user)
    @movement     = movement
    @depot_id     = depot_id
    @current_user = current_user
  end

  def depots
    @depots ||= @current_user.depots
  end
end
