require "minitest/autorun"
require "./lib/activity"

class ActivityTest < Minitest::Test

def test_has_name
  activity = Activity.new("Brunch")
  assert_equal "Brunch", activity.name
end

def test_participants_starts_empty_and_can_add_participants
    activity = Activity.new("Brunch")
    assert_equal ({}), activity.participants
    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)
    assert_equal ({"Maria" => 20, "Luther" => 40}), activity.participants
end

def test_split
  activity = Activity.new("Brunch")
  activity.add_participant("Maria", 20)
  activity.add_participant("Luther", 40)
  assert_equal 60, activity.total_cost
  assert_equal 30, activity.split
  assert_equal ({"Maria" => 10, "Luther" => -10}), activity.total_owed

end



end
