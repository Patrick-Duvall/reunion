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

def test_owed_per_activity
  @activity_1.add_participant("Maria", 20)
  @activity_1.add_participant("Luther", 40)
  @reunion.add_activity(@activity_1)
  assert_equal 60, @reunion.total_cost
  @activity_2.add_participant("Maria", 60)
  @activity_2.add_participant("Luther", 60)
  @activity_2.add_participant("Louis", 0)
  @reunion.add_activity(@activity_2)
  assert_equal [{"Maria"=>10, "Luther"=>-10}, {"Maria"=>-20, "Luther"=>-20, "Louis"=>40}], @reunion.owed_per_activity
end

def test_participants
  @activity_1.add_participant("Maria", 20)
  @activity_1.add_participant("Luther", 40)
  @activity_2.add_participant("Louis", 0)
  @reunion.add_activity(@activity_1)
  @reunion.add_activity(@activity_2)
  assert_equal %w(Maria Luther Louis), @reunion.participants
end

def test_breakout

  @activity_1.add_participant("Maria", 20)
  @activity_1.add_participant("Luther", 40)
  @reunion.add_activity(@activity_1)
  assert_equal 60, @reunion.total_cost
  @activity_2.add_participant("Maria", 60)
  @activity_2.add_participant("Luther", 60)
  @activity_2.add_participant("Louis", 0)
  @reunion.add_activity(@activity_2)
  assert_equal 180, @reunion.total_cost
  assert_equal ( {"Maria" => -10, "Luther" => -30, "Louis" => 40}), @reunion.breakout
  assert_equal "Maria: -10\nLuther: -30\nLouis: 40", @reunion.summary
end

def test_detailed_breakout
  reunion = Reunion.new("1406 BE")

  activity_1 = Activity.new("Brunch")
  activity_1.add_participant("Maria", 20)
  activity_1.add_participant("Luther", 40)

  activity_2 = Activity.new("Drinks")
  activity_2.add_participant("Maria", 60)
  activity_2.add_participant("Luther", 60)
  activity_2.add_participant("Louis", 0)

  activity_3 = Activity.new("Bowling")
  activity_3.add_participant("Maria", 0)
  activity_3.add_participant("Luther", 0)
  activity_3.add_participant("Louis", 30)

  activity_4 = Activity.new("Jet Skiing")
  activity_4.add_participant("Maria", 0)
  activity_4.add_participant("Luther", 0)
  activity_4.add_participant("Louis", 40)
  activity_4.add_participant("Nemo", 40)

  reunion.add_activity(activity_1)
  reunion.add_activity(activity_2)
  reunion.add_activity(activity_3)
  reunion.add_activity(activity_4)

  assert_equal ({
    "Maria" => [
      {
        activity: "Brunch",
        payees: ["Luther"],
        amount: 10
      },
      {
        activity: "Drinks",
        payees: ["Louis"],
        amount: -20
      },
      {
        activity: "Bowling",
        payees: ["Louis"],
        amount: 10
      },
      {
        activity: "Jet Skiing",
        payees: ["Louis", "Nemo"],
        amount: 10
      }
    ],
    "Luther" => [
      {
        activity: "Brunch",
        payees: ["Maria"],
        amount: -10
      },
      {
        activity: "Drinks",
        payees: ["Louis"],
        amount: -20
      },
      {
        activity: "Bowling",
        payees: ["Louis"],
        amount: 10
      },
      {
        activity: "Jet Skiing",
        payees: ["Louis", "Nemo"],
        amount: 10
      }
    ],
    "Louis" => [
      {
        activity: "Drinks",
        payees: ["Maria", "Luther"],
        amount: 20
      },
      {
        activity: "Bowling",
        payees: ["Maria", "Luther"],
        amount: -10
      },
      {
        activity: "Jet Skiing",
        payees: ["Maria", "Luther"],
        amount: -10
      }
    ],
    "Nemo" => [
      {
        activity: "Jet Skiing",
        payees: ["Maria", "Luther"],
        amount: -10
      }
    ]
  }), reunion.detailed_breakout

end
end
