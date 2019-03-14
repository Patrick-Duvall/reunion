require "./lib/reunion"
require "./lib/activity"
require "minitest/autorun"

class ReunionTest < Minitest::Test


def setup
  @reunion = Reunion.new('1406 BE')
  @activity_1 = Activity.new("Brunch")
  @activity_2 = Activity.new("Drinks")
end

def test_has_name
  assert_equal '1406 BE', @reunion.name
end

def test_has_and_can_add_activities
  assert_equal [], @reunion.activities
  @reunion.add_activity(@activity_1)
  assert_equal [@activity_1], @reunion.activities
end


end
