class Depot::CardComponent < ViewComponent::Base
  with_collection_parameter :depot

  def initialize(depot:)
    @depot = depot
  end
end
