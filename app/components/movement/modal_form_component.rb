class Movement::ModalFormComponent < ViewComponent::Base
  def initialize(movement, depot, url, current_user)
    @movement     = movement
    @depot        = depot
    @url          = url 
    @current_user = current_user
  end

  def depots
    @depots ||= @current_user.depots
  end
end
