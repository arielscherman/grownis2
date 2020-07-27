require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

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

  def test_sends_email
    assert_enqueued_with(job: SuggestionMailer.delivery_job) do
      Suggestion.create!(description: "a suggestion here!", user: users(:valid))
    end
  end
end
