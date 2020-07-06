class Movement::ModalFormComponent < ViewComponent::Base
  def initialize(movement, depot_id, url, current_user)
    @movement     = movement
    @depot_id     = depot_id
    @url          = url 
    @current_user = current_user
  end

  def depots
    @depots ||= @current_user.depots
  end
end
