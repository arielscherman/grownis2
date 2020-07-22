require 'test_helper'

class BugTest < ActiveSupport::TestCase
  def test_belongs_to_user
    assert_instance_of User, bugs(:bug).user
  end

  #
  # Validations
  #
  def test_presence_of_title
    bug = bugs(:bug)
    bug.title = ""

    bug.valid?
    assert bug.errors.details.has_key?(:title)
  end

  def test_presence_of_description
    bug = bugs(:bug)
    bug.description = ""

    bug.valid?
    assert bug.errors.details.has_key?(:description)
  end
end
