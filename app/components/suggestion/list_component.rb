class Suggestion::ListComponent < ViewComponent::Base
  def initialize(suggestions:)
    @suggestions = suggestions
  end
end
