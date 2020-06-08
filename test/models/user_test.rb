require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_presence_of_name
    user = users(:valid)
    user.username = ""

    user.valid?
    assert user.errors.details.has_key?(:username)
  end

  def test_has_many_depots
    assert_instance_of Depot, users(:valid).depots.first
  end
end
