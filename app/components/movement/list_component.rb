class Movement::ListComponent < ViewComponent::Base
  def initialize(movements:, show_depot: false)
    @movements  = movements
    @show_depot = show_depot
  end
end
