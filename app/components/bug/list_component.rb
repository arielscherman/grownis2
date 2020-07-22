class Bug::ListComponent < ViewComponent::Base
  def initialize(bugs:)
    @bugs = bugs
  end
end
