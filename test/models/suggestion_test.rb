require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  def test_belongs_to_user
    assert_instance_of User, suggestions(:suggestion).user
  end

  #
  # Validations
  #
  def test_presence_of_description
    suggestion = suggestions(:suggestion)
    suggestion.description = ""

    suggestion.valid?
    assert suggestion.errors.details.has_key?(:description)
  end
end
